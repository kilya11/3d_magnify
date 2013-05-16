% Lädt die Daten und filtered die Werten

framesNum = 30;
minDim = 111*111;
% pixel XY + point XYZ
columnNum = 2 + 2;

points = zeros(framesNum, columnNum, minDim);

clear global last_mask;
for i = 1:size(points, 1)
    filePath = ['../data/2Hz/pointcloud_all_N24_', int2str(i-1), '.pcf'];
    if mod(i, 10) == 0
        display(['Load ', filePath]);
    end
    
    listXYZ = read_file_xyz(filePath);
    
    listMask = mask_image2(listXYZ);
        
    points(i, :, :) = listMask;
end

filteredBase = points(:, 3:5, :);

filteredBase = permute(filteredBase, [3 2 1]);
filtered = ideal_bandpassing(filteredBase, 3, 1.5, 3, 204);
filtered = permute(filtered, [3 2 1]);

filtered(filtered < 0) = 0;

display('ready');
return;

show_points(points, 4);

show_filtered(points, filtered, 3);



