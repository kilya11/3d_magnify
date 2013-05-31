% spatial frequency (SF) filtering by SF-bandpass filter

% the SF filter is unselective to orientation (doughnut-shaped in the SF
% domain).
tic
% parameters for SF filtering
ctrSF = 1/(70*2); % center SF
s = 0.005; % sigma of Gaussian function
%ctrSF = 0;

show_log_amp = false; % flag to show log SF spectrum instead of SF spectrum
min_amp_to_show = 10 ^ -10; % small positive value to replace 0 for log SF spectrum

filtered_magnified = zeros(size(filtered));

img1 = filtered(1, 1, :);
img1 = reshape(img1, imgDim);

% calculate the number of points for FFT (power of 2)
FFT_pts = 2 .^ ceil(log2(size(img1)));

if 1
for i = 1:size(filtered, 1)
    for index = 1:2
        img = filtered(i, index, :);
        img = reshape(img, imgDim);
img(abs(img) > 0.2) = 0;
%img = blurDn(img, 1);
%img = imresize(img, imgDim);

        [img_spektrum fx fy mfx mfy] = Myff2(img, FFT_pts(1), FFT_pts(2));

        SF = sqrt(mfx .^ 2 + mfy .^ 2);

        % SF-bandpass and orientation-unselective filter
        filt = exp(-(SF - ctrSF) .^ 2 / (2 * s ^ 2));

        img_spektrum_filtered = filt .* img_spektrum; % SF filtering
        img_filtered = real(ifft2(ifftshift(img_spektrum_filtered))); % IFFT
        img_filtered = img_filtered(1: size(img, 1), 1: size(img, 2));

        filtered_magnified(i, index, :) = img_filtered(:);
    end
end
toc
return
end

img = filtered(5, 1, :);
        img = reshape(img, imgDim);
img(abs(img) > 0.2) = 0;
%img = blurDn(img, 1);
%img = imresize(img, imgDim);

        [img_spektrum fx fy mfx mfy] = Myff2(img, FFT_pts(1), FFT_pts(2));

        SF = sqrt(mfx .^ 2 + mfy .^ 2);

        % SF-bandpass and orientation-unselective filter
        filt = exp(-(SF - ctrSF) .^ 2 / (2 * s ^ 2));

        img_spektrum_filtered = filt .* img_spektrum; % SF filtering
        img_filtered = real(ifft2(ifftshift(img_spektrum_filtered))); % IFFT
        img_filtered = img_filtered(1: size(img, 1), 1: size(img, 2));


[img_spektrum fx fy mfx mfy] = Myff2(img, FFT_pts(1), FFT_pts(2));
%return;

figure(1);
clf reset;

colormap gray;

% luminance image
subplot(2, 2, 1);
imagesc(img);
colorbar;
axis square;
set(gca, 'TickDir', 'out');
title('a) Originalbild');
xlabel('x');
ylabel('y');

img_spektrum = abs(img_spektrum);
if show_log_amp
    img_spektrum(find(img_spektrum < min_amp_to_show)) = min_amp_to_show; % avoid taking log 0 
    img_spektrum = log10(img_spektrum);
end

% spectral amplitude
subplot(2, 2, 2);
imagesc(fx, fy, img_spektrum);
axis xy;
axis square;
set(gca, 'TickDir', 'out');
title('b) Frequenzpektrum');
xlabel('fx (1/px)');
ylabel('fy (1/px)');

% filter in the SF domain
subplot(2, 2, 3);
imagesc(fx, fy, filt);
axis xy;
axis square;
set(gca, 'TickDir', 'out');
title('c) Filtermaske');
xlabel('fx (1/px)');
ylabel('fy (1/px)');

% filtered image
subplot(2, 2, 4);
imagesc(img_filtered);
colorbar;
axis square;
set(gca, 'TickDir', 'out');
title('d) Gefiltertes Bild');
xlabel('x');
ylabel('y');
return

cx=65;cy=65;ix=128;iy=128;r=5;
[x,y]=meshgrid(-(cx-1):(ix-cx),-(cy-1):(iy-cy));
c_mask=((x.^2+y.^2)<=r^2);
imagesc(c_mask)