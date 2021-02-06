%% load saves
paramss = [];
tempres = [];
resss = [];
vss = [];

pumpdetuning = 0.241;

load('E:\NMRGGil\workingpoints_folder\probe_scan08-Jul-2020_1150.mat')
paramss = [paramss ;params];
tempres = [tempres; temp_resistance];
vss = [vss; vs];
resss= [resss; ress];
load('E:\NMRGGil\workingpoints_folder\probe_scan08-Jul-2020_1202.mat')
paramss = [paramss ;params];
tempres = [tempres; temp_resistance];
vss = [vss; vs];
resss= [resss; ress];
load('E:\NMRGGil\workingpoints_folder\probe_scan08-Jul-2020_1213.mat')
paramss = [paramss ;params];
tempres = [tempres; temp_resistance];
vss = [vss; vs];
resss= [resss; ress];
load('E:\NMRGGil\workingpoints_folder\probe_scan08-Jul-2020_1241.mat')
paramss = [paramss ;params];
tempres = [tempres; temp_resistance];
vss = [vss; vs];
resss= [resss; ress];
load('E:\NMRGGil\workingpoints_folder\probe_scan08-Jul-2020_1321.mat')
paramss = [paramss ;params];
tempres = [tempres; temp_resistance];
vss = [vss; vs];
resss= [resss; ress];
load('E:\NMRGGil\workingpoints_folder\probe_scan08-Jul-2020_1325.mat')
paramss = [paramss ;params];
tempres = [tempres; temp_resistance];
vss = [vss; vs];
resss= [resss; ress];
load('E:\NMRGGil\workingpoints_folder\probe_scan21-Jul-2020_1857.mat')
paramss = [paramss ;params];
tempres = [tempres; temp_resistance];
vss = [vss; vs];
resss= [resss; ress];
% load('E:\NMRGGil\workingpoints_folder\probe_scan21-Jul-2020_1658.mat')
% paramss = [paramss ;params];
% tempres = [tempres; temp_resistance];
% vss = [vss; vs];
% resss= [resss; ress];
% load('E:\NMRGGil\workingpoints_folder\probe_scan21-Jul-2020_1747.mat')
% paramss = [paramss ;params];
% tempres = [tempres; temp_resistance];
% vss = [vss; vs];
% resss= [resss; ress];
% vss
% resss
% paramss
% tempres


%% do things with them


params2s = [];
params3s = [];
ODs = [];
for i = 1:length(tempres)
    ress = resss(i,:);
    vs = vss(i,:);
    
res_nominal = @(x) (ress(end) - ress(1))/(vs(end) - vs(1))*(x - vs(1)) + ress(1);
[minval, ind] = min(ress);
% figure; plot(vs, ress, vs, res_nominal(vs))
base = res_nominal(vs(ind));
ODlin = minval/base;
ODlog = -log(ODlin);
ODs = [ODs; ODlog];

ress2 = ress - res_nominal(vs) + base;
% figure; plot(vs, ress2)
approx_width = 30e-3;
Lorentz_func = @(p,fx) -p(1)./(1+((fx-p(2))/p(3)).^2) + p(4); 
params = fminsearch(@(p) sum(abs( ress2 - Lorentz_func(p,vs) ).^2),...
    [max(abs(ress2)),vs(ind),0.25*approx_width, ress(1)]);

% figure;
% plot(vs,ress2,'-o', vs,(Lorentz_func(params,vs)),'--');
 
Lorentz_func2 = @(p,fx) p(3)*exp(-p(1)/p(3)./(1+((fx-p(2))/p(4)).^2)); 
params2 = fminsearch(@(p) sum(abs( ress2 - Lorentz_func2(p,vs) ).^2),...
    [max(abs(ress2)),vs(ind), ress(1),0.25*approx_width]);

% figure;plot(vs,ress2,'-o', vs,(Lorentz_func2(params2,vs)),'--');
params2s = [params2s ;params2];

width_as_seen_by_measurements = 28e-4;

Lorentz_func3 = @(p,fx) p(3)*exp(-p(1)/p(3)./(1+((fx-p(2))/width_as_seen_by_measurements).^2)); 
params3 = fminsearch(@(p) sum(abs( ress2 - Lorentz_func3(p,vs) ).^2),...
    [max(abs(ress2)),vs(ind), ress(1)]);

figure;plot(vs,ress2,'-o',vs,(Lorentz_func3(params3,vs)),'--');
params3s = [params3s ;params3];


%  minvolt = params(2)
%  minval2 = Lorentz_func(params, minvolt)
%  FWHM = 2*params(3)

end

smallODind = 2;
ODsa = params3s(:,1);
realODs = ODs(1)/ODsa(1)*ODsa

