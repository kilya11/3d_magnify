points2 = points(:, :, :);

index = 3;
indexF = 1;

factor = 1;
for i = 1:size(points2, 1)
    points2(i, 3, :) = points(i, 3, :) + filtered(i, 1, :) * factor;
    points2(i, 4, :) = points(i, 4, :) + filtered(i, 2, :) * factor;
end

% Darstellung des vergrößerten Bildes.
for i = 1:size(points2, 1)
    break;
    img = reshape(points2(i, index, :), [111 111]);
    imagesc(img);
    title(['Frame ' int2str(i) ])
    drawnow;
    pause(0.1)
end

for i = 1:size(points2, 1)
    filePath = ['../data/2Hz_magnified/pointcloud_all_N24_', int2str(i-1), '.pcf'];
    if mod(i, 10) == 0
        display(filePath);
    end
    
    m = points2(i, :, :);
    m = squeeze(m);
    m = m.';
    
    m(m(:, 3) == 0, :) = [];
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



