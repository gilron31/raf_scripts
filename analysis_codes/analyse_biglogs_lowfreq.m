biglogs = [];

load('E:\NMRGGil\proj1\enter_WP_sch2\Sch2_WPS_and_logs\lowfreq_hand_2\bz0.005\bz0.005biglog.mat')
bigLog.logXFID.WP_FID
biglogs = [biglogs , bigLog];

load('E:\NMRGGil\proj1\enter_WP_sch2\Sch2_WPS_and_logs\lowfreq_hand_2\bz0.01\bz0.01biglog.mat')
bigLog.logXFID.WP_FID
biglogs = [biglogs , bigLog];

load('E:\NMRGGil\proj1\enter_WP_sch2\Sch2_WPS_and_logs\test13_10_30mwPr_lowbz_sr830\test13_10_30mwPr_lowbz_sr830_Bz0.025_13-Oct-2020_132225\bigLog.mat')
bigLog.logXFID.WP_FID
biglogs = [biglogs , bigLog];

load('E:\NMRGGil\proj1\enter_WP_sch2\Sch2_WPS_and_logs\test13_10_30mwPr_lowbz_sr830\test13_10_30mwPr_lowbz_sr830_Bz0.02_13-Oct-2020_133518\bigLog.mat')
bigLog.logXFID.WP_FID
biglogs = [biglogs , bigLog];

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

for i = 1:length(biglogs)
    finalWP = biglogs(i).logXFID.WP_FID;
    
    
    as_wp(i) = finalWP.Floquet_fast_amp_Vpp;
    fs_wp(i) = finalWP.FLoquet_fast_freq_hz;
    liaphase(i) = finalWP.LIAESR_phase;
    Bxdc(i) = finalWP.Bx_DC_V;
    Bydc(i) = finalWP.By_DC_V;

%     fs_FAAR(i) = biglogs(i).logFAAR.WPend.FLoquet_fast_freq_hz;
% 
%     Bxresmag(i) = biglogs(i).logMAGS.Bx_response_V_2_G;
%     Byresmag(i) = biglogs(i).logMAGS.By_response_V_2_G;
%     
%     fxe_fid(i) = biglogs(i).logSXERES.f_0;
%     G2xe_fid(i) = biglogs(i).logSXERES.G2estim;
%     fxe_nmr(i) = biglogs(i).logSXERES.ff.c;
%     G2xe_nmr(i) = biglogs(i).logSXERES.ff.b * 2 * pi;
%     G2alk(i) =  biglogs(i).logFAAR.fminParams(4);
%     Efactor(i) = biglogs(i).logSXERES.Xe_max_amp_V_2_G / biglogs(i).logMAGS.By_response_V_2_G;
      bzs(i) = finalWP.BBcurrent;
%     figure(2213);plot(biglogs(i).logSXERES.ff,biglogs(i).logSXERES.fspan, biglogs(i).logSXERES.Xe_res);hold on;
    


end


fita = polyfit(bzs, as_wp, 1)
fitf = polyfit(bzs, fs_wp, 1)
fitbx = polyfit(bzs, Bxdc, 1)
fitby = polyfit(bzs, Bydc, 1)

figure; plot(bzs, as_wp, 'x', bzs, fita(1)*bzs + fita(2))
figure; plot(bzs, fs_wp, 'x',bzs, fitf(1)*bzs + fitf(2))
figure; plot(bzs, Bxdc, 'x',bzs, fitbx(1)*bzs + fitbx(2))
figure; plot(bzs, Bydc, 'x',bzs, fitby(1)*bzs + fitby(2))









