function [ biglogs ] = series_2_biglogs( parent_folder, TXT1, before_after)
biglogs = [];
bzs = [];
files = dir(parent_folder);
dirs = files([files.isdir]);
dirs = dirs(3:end)


[w, inds] = sort([dirs.datenum])
dirs = dirs(inds)

for i =1:length(dirs)
i
subfold = [parent_folder '\' dirs(i).name '\' TXT1];
files2 = dir(subfold);
dirs2 = files2([files2.isdir]);
if(before_after)
subfold = [subfold '\' dirs2(3).name];
else    
subfold = [subfold '\' dirs2(4).name];
end
load([subfold '\bigLog.mat' ])
biglogs = [biglogs , bigLog];
end


end

