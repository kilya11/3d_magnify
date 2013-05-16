addpath('./matlabPyrTools');

imgL = [];
imgR = [];
overlap = [];
for i = 1:300
    filePath = ['../data/2Hz/pointcloud_all_N24_', int2str(i-1), '.pcf']
    %filePath = ['../data/2Hz/pointcloud_all_N15_', '.pcf']
    
    %[cameraL, cameraR] = read_file(filePath);
    
    %[iL, iR] = mask_image(cameraL, cameraR);
    %imgL(i,:,:) = iL;
    %imgR(i,:,:) = iR;
    if (size(imgR, 1) > 1) && (i > 1)
        overlap(size(overlap, 1) + 1, :, :) = squeeze(imgR(i - 1, :, :)) + squeeze(imgR(i,:,:));
    end    
end

overlap = zeros(size(imgR));
for i = 2:300
    %overlap(i, :, :) = squeeze(imgR(i - 1, :, :)) + squeeze(imgR(i,:,:));
    
end

%overlap(overlap ~= 1 & overlap > 0) = 0.5;
%overlap(overlap == 1) = 0;
overlap(overlap ~= 1) = 0;

dim = size(imgR);
im = zeros(dim(1), dim(2) * dim(3));
for i=1:dim(1)
    im(i, :) = imgR(i, :);
end 

filtered = ideal_bandpassing(im, 2, 1, 3, 204);
filtered = ideal_bandpassing(filtered, 1, 1, 3, 204);

filtered = reshape(filtered, dim);
filtered(filtered < 0) = 0;
max3 = max(max(max(filtered)));
filtered = filtered + max3;
filtered = filtered / max3;
filtered(filtered > 0.2) = 0;
filtered(filtered < 0.1) = 0;
return
filtered = overlap;
filtered(filtered < 0) = 0;
samplingRate = 204;
maxList = zeros(300, 2);

for i = 1:300
    img = squeeze(filtered(i, :, :));
    maxList(i, 1) = max(max(img));
    maxList(i, 2) = mean(mean(img));
    
    img(img < 0.02)=0;
    imagesc(img);
    title(['Frame ' int2str(i) ])
    drawnow;
    %pause(0.05)
end
%scatter(x, y, '.');
%spy(img_core);

samplingRate = 5000;

% Signal parameters:
f = [ 40 100  ];      % frequencies   
M = 512;                        % signal length 

frames = 10;
x = zeros(frames, M); % pre-allocate 'accumulator'
n = 0:(M-1);    % discrete-time grid 
for frame=1:frames
    % Generate a signal by adding up sinusoids:
    for fk = f; 
        x(frame, :) = x(frame, :) + sin(2*pi*n*fk/samplingRate); 
    end
end

filtered = ideal_bandpassing(x, 2, 30, 50, samplingRate);
plot(n, x(1, :));
hold all;
plot(n, filtered(1, :));
