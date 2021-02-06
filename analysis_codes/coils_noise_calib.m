scope1.Single()
[t,v] = scope1.Read(3);
% t_calib = t;v_calib = v;


calibfreq = 173.1333;
calibampVpp = 100e-3;
coils_calib.Bx_G2V_dora = 0.008; 
simAmp_sc = trapz( (t_calib(2)-t_calib(1)) *2*1i*exp(-1i*2*pi*calibfreq* t_calib ).*( v_calib - mean( v_calib )))/diff(minmax( t_calib ));

V_2_G_sc = abs(simAmp_sc )/ (coils_calib.Bx_G2V_dora*calibampVpp/2)


scope1.Single()
[t,v] = scope1.Read(3);
t_N1 = t;v_N1= v;

NBW_1 = 1e3;
Nampmvpp_1 = 1e-3;

[Sf,f] =pwelch(v_N1/V_2_G_sc,[],[],[],1/(t_N1(2)-t_N1(1)));

figure(59);  
loglog(f,sqrt(Sf),'x');hold all;grid on;

maxf = 500;
minf = 100;
sqrtsf = sqrt(Sf);
sfff = sqrtsf(f<maxf & f>minf);

NF_1_G = mean(sfff)



scope1.Single()
[t,v] = scope1.Read(3);
t_N2 = t;v_N2= v;

NBW_2 = 1e3;
Nampmvpp_2 = 5e-3;

[Sf,f] =pwelch(v_N2/V_2_G_sc,[],[],[],1/(t_N2(2)-t_N2(1)));

figure(59);  
loglog(f,sqrt(Sf),'x');hold all;grid on;

maxf = 500;
minf = 100;
sqrtsf = sqrt(Sf);
sfff = sqrtsf(f<maxf & f>minf);

NF_2_G = mean(sfff)

%xnoise
scope1.Single()
[t,v] = scope1.Read(2);
t_NXe1 = t;v_NXe1= v;
Namp = 1e-3;
NBw = 1e3;
[Sf,f] =pwelch(v_NXe1/bigLog.FinalParameters.Alk_V_2_G,[],[],[],1/(t_NXe1(2)-t_NXe1(1)));
figure(59);  
loglog(f,sqrt(Sf),'x');hold all;grid on;


%ynoise
scope1.Single()
[t,v] = scope1.Read(2);
t_NXe2 = t;v_NXe2= v;
Namp = 1e-3;
NBw = 1e3;
[Sf,f] =pwelch(v_NXe2/bigLog.FinalParameters.Alk_V_2_G,[],[],[],1/(t_NXe2(2)-t_NXe2(1)));
figure(59);  
loglog(f,sqrt(Sf),'x');hold all;grid on;

%%
NF_2_NA = NF_2_G/Nampmvpp_2 %2.63e-5
%%
generate_workingpoint;
WPcurr = WP;

ATTEN = 100;

AG5.DC(2, WP.Bx_DC_V);

log_Nan = noise_spectrum_func(scope1, 20, 1,bigLog.logMAGS2.onresY,bigLog.finalWP,1);

amps1 = (1:1:10)*1e-3;
logs = [];

for amp = amps1
    fprintf(AG5.Ins, ['SOURce2:VOLT ',num2str(amp)])

    
    logi = noise_spectrum_func(scope1, 20, 1,bigLog.logMAGS2.onresY,bigLog.finalWP,1);
    logs = [logs , logi];
    
end

amps2 = (1:0.5:10)*1e-3;
logs2 = [];

for amp = amps2
    fprintf(AG5.Ins, ['SOURce2:VOLT ',num2str(amp)])

    
    logi = noise_spectrum_func(scope1, 20, 1,bigLog.logMAGS2.onresY,bigLog.finalWP,1);
    logs2 = [logs2 , logi];
    
end

powers = [];

for i = 1:length(logs)
    power = max(sqrt(logs(i).Sf(logs(i).f<180 & logs(i).f>170)));
    powers = [powers , power];
    
end
powers2 = [];

for i = 1:length(logs2)
    power = max(sqrt(logs2(i).Sf(logs2(i).f<180 & logs2(i).f>170)));
    powers2 = [powers2 , power];
    
end


figure; plot(amps1, powers, amps2, powers2)
figure; plot( amps2, powers2)

totalpowers = [powers, powers2];
totalamps = [amps1, amps2];

figure; plot(totalamps, totalpowers)
pf = polyfit(amps2, powers2, 1)
pf(2)

lowlim = 160
uplim = 190
figure(10)
for i = [1,19]
logx = logs2(i)
loglog(logx.f(logx.f<uplim & logx.f>lowlim), sqrt(logx.Sf(logx.f<uplim & logx.f>lowlim)), 'x');grid on
hold on
end
