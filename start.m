% Lädt die Daten und filtered die Werten

framesNum = 300;
minDim = 111*111;
% pixel XY + pixel2 XY + Korespondenz
columnNum = 5;

points = zeros(framesNum, columnNum, minDim);

clear global last_mask;
for i = 1:size(points, 1)
    filePath = ['../data/2Hz/pointcloud_all_N24_', int2str(i-1), '.pcf'];
    if mod(i, 10) == 0
        display(['Loading ', filePath]);
    end
    
    listXYZ = read_file_xyz(filePath);
    
    listMask = mask_image(listXYZ);
        
    points(i, :, :) = listMask;
end

    
img = reshape(points(1, 3, :), [111 111]);
imagesc(img);
return;
[pyr, pind] = buildLpyr(img, 'auto');

i = 111*111;
i2 = i+56*56;
pyr1 = pyr(1:i);
pyr1 = reshape(pyr1, [111 111]);
imagesc(pyr1(50-15:50+20,50-10:50+20));

filteredBase = pointsNorm(:, 3:4, :);

filteredBase = permute(filteredBase, [3 2 1]);
filtered = ideal_bandpassing(filteredBase, 3, 1.5, 3, 204/3);
filtered = permute(filtered, [3 2 1]);

filtered(filtered < 0) = 0;

display('ready');
return;

show_points(pointsNorm2, 4);

show_filtered(points, filtered, 2);



