points2 = points(:, :, :);

index = 3;
indexF = 1;

%factor = 200;
for i = 1:size(points2, 1)
    points2(i, 3, :) = pointsNorm(i, 3, :) + filtered_magnified(i, 1, :) * factor;
    points2(i, 4, :) = pointsNorm(i, 4, :) + filtered_magnified(i, 2, :) * factor;
end
return
%factor = 100;

%saveDir = ['../data/2Hz_magnified_x', int2str(factor), '_l_', int2str(lambda_c)];
saveDir = ['../data/3Hz_magnified_x', int2str(factor), '_100mV'];
mkdir(saveDir);

for i = 1:size(points2, 1)
    filePath = [saveDir, '/pointcloud_all_N21_', int2str(i-1), '.pcf'];
    if mod(i, 10) == 0
        display(filePath);
    end
    
    m = points2(i, :, :);
    m = squeeze(m);
    m = m.';
    
    mask = isnan(m(:, 3));
    m(mask, :) = [];
    %m(m(:, 4) == 0, :) = [];
    
    fileId = fopen(filePath, 'w');
    %fseek(fileId, 0, 'bof');
    frewind(fileId);
    fprintf(fileId, 'PCF1.0\n');
    fprintf(fileId, 'B0 H1 P0 C0 N0\n');
    fclose(fileId);
    
    dlmwrite(filePath, m, '-append', 'delimiter', ' ', 'newline', 'pc');
end

display('ready');



