addpath('./matlabPyrTools');

dim = size(points);
blurred = zeros(dim(1), dim(2) - 2, 56*56);
for i = 1:dim(1)
    img1 = zeros(110, 110);
    img2 = zeros(110, 110);
    img3 = zeros(110, 110);
    for k = 1:dim(3)
        x = points(i, 1, k) - 290 + 1;
        y = points(i, 2, k) - 190 + 1;
        if x == 50 && y == 30
            %display(k);
        end
        img1(x, y) = points(i, 3, k);
        img2(x, y) = points(i, 4, k);
        img3(x, y) = points(i, 5, k);
    end
    
    blurred(i, 1, :) = reshape(blurDn(img1), [56*56 1]);
    blurred(i, 2, :) = reshape(blurDn(img2), [56*56 1]);
    blurred(i, 3, :) = reshape(blurDn(img3), [56*56 1]);
    %imagesc(imgBlur);
    %pause(0.1);
end

filteredBase = permute(blurred, [3 2 1]);
filteredBlur = ideal_bandpassing(filteredBase, 3, 1.5, 3, 204);
filteredBlur = permute(filteredBlur, [3 2 1]);

show_blurred(filteredBlur, 2);