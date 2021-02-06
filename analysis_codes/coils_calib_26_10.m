Bx_vs = [1.0, 2.0, 3.0];
fs_bx = [9, 18.3, 27.9];

By_vs = [1.0, 2.0, 3.0];
fs_by = [9.0, 18.8, 28.9];

g129 = abs(-7.441e3); %rad/s/G

Bx_Gs = fs_bx /(g129 /(2*pi));
By_Gs = fs_by /(g129 /(2*pi));

fitx = polyfit(Bx_vs, Bx_Gs,1)
fity = polyfit(By_vs, By_Gs,1)

% fitx =
% 
%    0.0080    -0.0004
% 
% 
% fity =
% 
%    0.0084    -0.0008