% GDOWN_STACK = build_GDown_stack(VID_FILE, START_INDEX, END_INDEX, LEVEL)
% 
% Apply Gaussian pyramid decomposition on points 
% and select a specific band indicated by LEVEL
% 
% GDOWN_STACK: stack of one band of Gaussian pyramid of each frame 
% the first dimension is the time axis
% the second dimension is the y axis of the video
% the third dimension is the x axis of the video
% the forth dimension is the color channel
% 
% Copyright (c) 2011-2012 Massachusetts Institute of Technology, 
% Quanta Research Cambridge, Inc.
%
% Authors: Hao-yu Wu, Michael Rubinstein, Eugene Shih, 
% License: Please refer to the LICENCE file
% Date: June 2012
%
function GDown_stack = build_GDown_stack(points, level)

    imgSize = [111 111];
    
    img1 = reshape(points(1, 3, :), imgSize);
    img2 = reshape(points(1, 4, :), imgSize);

    blurred = blurDn(img1, level);
    blurred2 = blurDn(img2, level);
        
    k = 1;
    % create pyr stack
    GDown_stack = zeros(size(points, 1), size(blurred,1), size(blurred,2), 2);
    GDown_stack(k,:,:,1) = blurred;
    GDown_stack(k,:,:,2) = blurred2;

    for i = 2:size(points, 1)
        k = k+1;
        img1 = reshape(points(i, 3, :), imgSize);
        img2 = reshape(points(i, 4, :), imgSize);

        % create pyr stack
        GDown_stack(k,:,:,1) = blurDn(img1, level);
        GDown_stack(k,:,:,2) = blurDn(img2, level);
    end
    
end
