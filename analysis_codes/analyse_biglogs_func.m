function [  ] = analyse_biglogs_func( dirtobrowse )
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here

%% analysing the biglogs

biglogs = {};
bzs = [];
files = dir(dirtobrowse);
dirs = files([files.isdir]);
for i =3:length(dirs)-1
i,[dirtobrowse '\' dirs(i).name '\bigLog.mat']

    load([dirtobrowse '\' dirs(i).name '\bigLog.mat'])
biglogs = [biglogs , bigLog];
end

fs_wp = zeros(1,length(biglogs));
as_wp = zeros(1,length(biglogs));
fxe_fid = zeros(1,length(biglogs));
G2xe_fid = zeros(1,length(biglogs));
fxe_nmr = zeros(1,length(biglogs));
G2xe_nmr = zeros(1,length(biglogs));
G2alk = zeros(1,length(biglogs));
Efactor = zeros(1,length(biglogs));
liaphase = zeros(1,length(biglogs));
Bxdc = zeros(1,length(biglogs));
Bydc = zeros(1,length(biglogs));
fs_FAAR = zeros(1,length(biglogs));
Bxresmag = zeros(1,length(biglogs));
Byresmag = zeros(1,length(biglogs));
bzs = zeros(1,length(biglogs));
pumps = zeros(1,length(biglogs));
temps = zeros(1,length(biglogs));
means = zeros(1,length(biglogs));
stds = zeros(1,length(biglogs));
for i = 1:length(biglogs)
    finalWP = biglogs{i}.logXFID.WP_FID;

    pumps(i) = finalWP.pump_detune_V;
    as_wp(i) = finalWP.Floquet_fast_amp_Vpp;
    fs_wp(i) = finalWP.FLoquet_fast_freq_hz;
    liaphase(i) = finalWP.LIAESR_phase;
    Bxdc(i) = finalWP.Bx_DC_V;
    Bydc(i) = finalWP.By_DC_V;
    temps(i) =R2T( biglogs{i}.resTemp);

%     fs_FAAR(i) = biglogs{i}.logFAAR.WPend.FLoquet_fast_freq_hz;

%     Bxresmag(i) = biglogs{i}.logMAGS.Bx_response_V_2_G;
%     Byresmag(i) = biglogs{i}.logMAGS.By_response_V_2_G;
%     
    fxe_fid(i) = biglogs{i}.logSXERES.f_0;
%     G2xe_fid(i) = biglogs{i}.logSXERES.G2estim;
    fxe_nmr(i) = biglogs{i}.logSXERES.ff.c;
%     G2xe_nmr(i) = biglogs{i}.logSXERES.ff.b * 2 * pi;
% %     G2alk(i) =  biglogs{i}.logFAAR.fminParams(4);
%     Efactor(i) = biglogs{i}.logSXERES.Xe_max_amp_V_2_G / biglogs{i}.logMAGS.By_response_V_2_G;
    bzs(i) = finalWP.BBcurrent;
% %     figure(2213);plot(biglogs{i}.logSXERES.ff,biglogs{i}.logSXERES.fspan, biglogs{i}.logSXERES.Xe_res);hold on;
%     means(i) = biglogs{i}.logNS.meanint;
% %     stds(i) = biglogs{i}.logNS.stding;
end

figure(9991); plot(bzs, as_wp, 'x');title('as_wp')
figure(9992); plot(bzs, fs_wp, 'x');title('fs_wp')%, bzs, fs_FAAR, 'x');title('fs_wp - fs_FAAR')
figure(9993); plot(bzs, Bxdc, 'x');title('Bx')
figure(9994); plot(bzs, Bydc, 'x');title('By')%, bzs, fs_FAAR, 'x');title('fs_wp - fs_FAAR')

aslinfit = polyfit(bzs, as_wp,1);
fslinfit = polyfit(bzs, fs_wp,1);
Bxlinfit = polyfit(bzs, Bxdc,1);
Bylinfit = polyfit(bzs, Bydc,1);


Xe_129_res_linfit = polyfit(bzs, fxe_nmr, 1);

figure; plot(bzs, bzs*Xe_129_res_linfit(1) + Xe_129_res_linfit(2) - fxe_nmr, 'x')
% figure(9993); plot(bzs, Byresmag, 'x', bzs, 10*Bxresmag, 'x');title('Byresmag -  10*Bxresmag');hold on
% figure(9993); plot(bzs, Byresmag, 'x');title('Byresmag -  10*Bxresmag');hold on

% figure(9994); plot(bzs, fxe_fid, 'x', bzs, fxe_nmr, 'x');title('fxe_fid - fxe_nmr')
% figure(9995); plot(bzs, G2xe_nmr, 'x', bzs, G2xe_fid, 'x');title('G2xe_nmr - G2xe_fid')
% figure(9996); plot(bzs, Efactor, 'x');title('Efactor');hold on
% figure(9997); plot(bzs, G2alk, 'x');title('G2alk')

% 
% figure(9991); plot(pumps, as_wp, 'x');title('as_wp')
% figure(9992); plot(pumps, fs_wp, 'x', pumps, fs_FAAR, 'x');title('fs_wp - fs_FAAR')
% 
% figure(99931); plot(pumps, Byresmag, 'x', pumps, 10*Bxresmag, 'x');title('Byresmag -  10*Bxresmag');hold on
% % figure(9993); plot(bzs, Byresmag, 'x');title('Byresmag -  10*Bxresmag');hold on
% 
figure(99941); plot(bzs, fxe_fid, 'x', bzs, fxe_nmr, 'x');title('fxe_fid - fxe_nmr')
% figure(99951); plot(pumps, G2xe_nmr, 'x', pumps, G2xe_fid, 'x');title('G2xe_nmr - G2xe_fid');hold on

% figure(99971); plot(pumps, G2alk, 'x');title('G2alk')
% 
% figure(99951); plot(pumps, G2xe_nmr, 'x');title('G2xe_nmr -');hold on
% figure(99961); plot(pumps, Efactor, 'x');title('Efactor');hold on
% figure(99981); plot(pumps, G2xe_nmr.*Efactor, 'x');title('G2Xe*Efactor');hold on
% figure(99991); plot(pumps, temps);title('temps'); hold on
% figure(99791); plot(pumps, Byresmag.*Efactor, 'x');title('mag*Efactor');hold on

% figure(99781); plot( G2xe_nmr.*Efactor, 'x');title('G2Xe*Efactor');hold on
% figure(99761); plot(Efactor, 'x');title('Efactor');hold on
% figure(99751); plot( Byresmag.*Efactor, 'x');title('mag*Efactor');hold on
% figure(99721); plot( temps, 'x');title('temps');hold on
% figure(99701); plot( pumps, 'x');title('pumps');hold on
% figure(99711); plot(Efactor./means*20e-11 , 'x');title('FOM1');hold on

figure(99681); plot(bzs, G2xe_nmr.*Efactor, 'x');title('G2Xe*Efactor');hold on
figure(99661); plot(bzs,Efactor, 'x');title('Efactor');hold on
figure(99651); plot( bzs,Byresmag.*Efactor, 'x');title('mag*Efactor');hold on
figure(99621); plot( temps, 'x');title('temps');hold on
figure(99601); plot( bzs,pumps, 'x');title('pumps');hold on
figure(99611); plot(bzs,Efactor./means*20e-11 , 'x');title('FOM1');hold on
% 
% % 
% figure(99251); plot( log10(means), 'x');title('means');hold on
% figure(99221); plot( log10(stds), 'x');title('stds');hold on
% figure(94951); plot(G2xe_nmr, 'x');title('G2xe_nmr -');hold on
% figure(94961); plot(Efactor, 'x');title('Efactor');hold on
% figure(94991); plot(temps,'x');title('temps'); hold on

end

