% [LPYR_STACK, pind] = build_Lpyr_stack(points)
% 
% Apply Laplacian pyramid decomposition on points
% 
% LPYR_STACK: stack of Laplacian pyramid of each frame 
% the second dimension is the color channel
% the third dimension is the time
%
% pind: see buildLpyr function in matlabPyrTools library
% 
function [Lpyr_stack, pind] = build_Lpyr_stack(points)

    imgSize = [111 111];
    %imgSize = [36 31];
    
    img1 = reshape(points(1, 3, :), imgSize);
    img2 = reshape(points(1, 4, :), imgSize);

    [pyr, pind] = buildLpyr(img1, 'auto');

    % pre-allocate pyr stack
    Lpyr_stack = zeros(size(pyr, 1), 2, size(points, 1));

    k = 1;
    Lpyr_stack(:, 1, k) = pyr;
    [Lpyr_stack(:, 2, k), ~] = buildLpyr(img2, 'auto');

    for i = 2:size(points, 1)
        k = k + 1;

        img1 = reshape(points(i, 3, :), imgSize);
        img2 = reshape(points(i, 4, :), imgSize);

        [Lpyr_stack(:, 1, k), ~] = buildLpyr(img1, 'auto');
        [Lpyr_stack(:, 2, k), ~] = buildLpyr(img2, 'auto');
    end
end
