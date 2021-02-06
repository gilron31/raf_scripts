TXT1 = 'WPS_before_and_after';
% TXT2 = 'long_recordings';
parent_folder = 'G:\real_recordings\run1_highs';

% bigLogsafter = series_2_biglogs(parent_folder, TXT1, 0);
bigLogsbefore = series_2_biglogs(parent_folder, TXT1, 1);

% parent_folder1 = 'G:\test recordings\gil_tests_fast_10mwpr';
% bigLogsthorough = series_2_biglogs(parent_folder1, TXT1, 1);

% [fWPsa, fPsa, logsFIDa, logsSXa ] = extract_bigLogs(bigLogsafter);
% [fWPsb, fPsb , logsFIDb, logsSXb, initWPs] = extract_bigLogs(bigLogsbefore);

% [fWPsb, fPsb , logsFIDb, logsSXb, initWPs, logsSXMAGS] = extract_bigLogs(bigLogsbefore);

[fWPsb, fPsb , logsFIDb, logsSXb, initWPs, logsSXMAGS] = extract_bigLogs(bigLogsbefore);
% [fWPsbt, fPsbt , logsFIDbt, logsSXbt, initWPst, logsSXMAGSt] = extract_bigLogs(bigLogsthorough);


fidfreqsb = [];
fidG2s = [];
% fidfreqsa = [];
sxeresfreqb = [];
sxeresG2s = [];
desfreb = [];

% alkmagby_fast = [];

% Xemagb1s = [];
Xemagb2s = [];
Xemagb2sx = [];

% alkmagby1s = [];
% alkmagbx1s = [];
alkmagby2s = [];
alkmagbx2s = [];

for i=1:length(bigLogsbefore)
% fidfreqsa = [fidfreqsa, logsFIDa(i).logAXT2.ff.c];
fidG2s = [fidG2s, logsFIDb(i).logAXT2.ff.b];

% sxeresG2s = [sxeresG2s,  logsSXb(i).ff.b * 2 * pi];

fidfreqsb = [fidfreqsb,   logsFIDb(i).logAXT2.ff.c ];
% sxeresfreqb = [sxeresfreqb, logsSXb(i).ff.c];

% Xemagb1s = [Xemagb1s, logsSXb(i).Xe_max_amp_V_2_G];
% alkmagbx1s = [alkmagbx1s, bigLogsbefore(i).logMAGS2.onresX];
% alkmagby1s = [alkmagby1s, bigLogsbefore(i).logMAGS2.onresY];

offresampx1 = abs(logsSXMAGS(i).res_forx(1,2));
onresampx = abs(logsSXMAGS(i).res_forx(2,2));
offresampx2 = abs(logsSXMAGS(i).res_forx(3,2));
offresampy1 = abs(logsSXMAGS(i).res_fory(1,1));
onresampy = abs(logsSXMAGS(i).res_fory(2,1));
offresampy2 = abs(logsSXMAGS(i).res_fory(3,1));
driveamp_G= logsSXMAGS.driveamp_G;
% xAmpVpp = 1e-3; Bx_G_2_V = 0.008;
% driveamp_G=xAmpVpp/2*Bx_G_2_V;

alkmagbx2 = (offresampx1+offresampx2)/2/driveamp_G;
alkmagby2 = (offresampy1+offresampy2)/2/driveamp_G;

Xeamp2x = onresampx/driveamp_G - alkmagbx2;
Xeamp2y = onresampy/driveamp_G - alkmagby2;

alkmagbx2s = [alkmagbx2s,alkmagbx2];
alkmagby2s = [alkmagby2s,alkmagby2];

Xemagb2s = [Xemagb2s,Xeamp2y];
Xemagb2sx = [Xemagb2sx,Xeamp2x];

% Xemagb2 = [Xemagb2, logsFIDb(i).logAXT2.ff.c];
end



% figure; plot([fPsa.f_Xe], [fPsa.f_Xe] - fidfreqsa, 'x', [fPsa.f_Xe],[fPsa.f_Xe] - [fPsb.f_Xe],'x', [fPsa.f_Xe],  [fPsa.f_Xe] - fidfreqsb,'x',[fPsa.f_Xe],  [fPsa.f_Xe] - fs,'x')

figure; plot(fidfreqsb,  alkmagbx2s, 'x')
figure; plot(fidfreqsb, [initWPs.Floquet_fast_amp_Vpp] - [fWPsb.Floquet_fast_amp_Vpp], 'x'); title('amps')
figure; plot(fidfreqsb, [initWPs.FLoquet_fast_freq_hz]- [fWPsb.FLoquet_fast_freq_hz], 'x');title('freqs')

figure; plot(fidfreqsb, [fWPsb.FLoquet_fast_freq_hz], 'x');title('freqs')

figure; plot(fidfreqsb, [fWPsb.Floquet_fast_amp_Vpp], 'x');title('amps')

Flowlinfit = polyfit([fWPsb.BBcurrent],[fWPsb.FLoquet_fast_freq_hz],1)
Alowlinfit = polyfit([fWPsb.BBcurrent],[fWPsb.Floquet_fast_amp_Vpp],1)


Bxlowlinfit = polyfit([fWPsb.BBcurrent],[fWPsb.Bx_DC_V],1)
Bylowlinfit = polyfit([fWPsb.BBcurrent],[fWPsb.By_DC_V],1)

figure; plot([fWPsb.BBcurrent], fidfreqsb,'x')

ffidfit = polyfit([fWPsb.BBcurrent],fidfreqsb,1)

figure; plot([fWPsb.BBcurrent], fidfreqsb - [fWPsb.BBcurrent]*ffidfit(1) - ffidfit(2),'x')

figure; plot(fidfreqsb, Xemagb2s, 'x', fidfreqsb, Xemagb2sx, 'x') 

figure; plot(fidfreqsb, [fWPsb.Bx_DC_V], 'x')
figure; plot(fidfreqsb, [fWPsb.By_DC_V], 'x')

figure; plot(fidfreqsb, [fPsb.FOM1], 'x')
