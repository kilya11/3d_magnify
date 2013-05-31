% Lädt die Daten und filtered die Werten
clear all;
cd ('C:/Users/Ilja/Documents/Documents/fsu/BA/3d_magnify');

framesNum = 300;
global imgDim;% [111 111];
% pixel XY + pixel2 XY + Korespondenz
columnNum = 5;


clear global last_mask;
for i = 1:framesNum
    %filePath = ['../data/2Hz/pointcloud_all_N24_', int2str(i-1), '.pcf'];
    filePath = ['../data/3Hz/0.131V/pointcloud_all_N21_', int2str(i-1), '.pcf'];
    if mod(i, 10) == 0
        display(['Loading ', filePath]);
    end
    
    listXYZ = read_file_xyz(filePath);
    [listMask, imgDim] = mask_image(listXYZ);
    
    if ~exist('points', 'var')
        points = zeros(framesNum, columnNum, prod(imgDim));
        display('zeros')
    end

    points(i, :, :) = listMask;
end
save('../data/3Hz/0.1_points.mat',  'points');
return;
img = reshape(points(1, 3, :), imgDim);
imagesc(img);
%mesh(img)
return;
[pyr, pind] = buildLpyr(img, 'auto');

i = 111*111;
i2 = i+56*56;
pyr1 = pyr(1:i);
pyr1 = reshape(pyr1, [111 111]);
%imagesc(pyr1(50-15:50+20,50-10:50+20));
imagesc(pyr1);

filteredBase = pointsNorm(:, 3:4, :);

filteredBase = permute(filteredBase, [3 2 1]);
tic
filtered = ideal_bandpassing(filteredBase, 3, 2.5, 3.5, 185/3);
toc
filtered = permute(filtered, [3 2 1]);
show_filtered(points, filtered, 1);
%filtered(filtered < 0) = 0;

display('ready');
return;

show_points(points, 3);

show_filtered(points, filtered_magnified, 1);

img = filtered(20, 1, :);
img = reshape(img, imgDim);
imagesc(img);

