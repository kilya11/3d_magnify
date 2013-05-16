addpath('./matlabPyrTools');

%{
smallW = 15+20+1;
smallH = 10+20+1;
pointsSmall = zeros(size(points, 1), size(points, 2), smallW*smallH);
imgSize = [111 111];
for i = 1:size(points, 1)

    img = points(i, 3, :);
    img = reshape(img, imgSize);

    filtered = img(50-15:50+20, 50-10:50+20);
    pointsSmall(i, 3, :) = filtered(:);
end

[pyr_stack, pind] = build_Lpyr_stack(pointsSmall(:, :, :));

pyrSmall = zeros(size(pointsSmall));

numPixels = smallW*smallH;
for i=1:size(pointsSmall, 1)
    pyrSmall(i, 3, :) = pyr_stack(1:numPixels, 1, i);
end

maxLim = max(max(max(pyrSmall(:,3,:))));
minLim = min(min(min(pyrSmall(:,3,:))));
lim = [minLim maxLim]
for i = 1:size(pyrSmall, 1)

    img = pyrSmall(i, 3, :);
    img = reshape(img, [smallW smallH]);

    imagesc(img);
    caxis(lim);
    title(['Frame ' int2str(i) ]);
    drawnow;
    pause(0.05);
end
return;
%}
[pyr_stack, pind] = build_Lpyr_stack(pointsNorm(:, :, :));

if 1
    numPixels = 111*111;
    numPixels2 = numPixels + 56*56;
    for i = 1:size(points, 1)
        if 0
            pyr = pyr_stack(1:numPixels, 1, i);
            filtered = reshape(pyr, [111 111]);
            filtered = filtered(:, 4:111-3);
        else
            pyr = filtered_stack(numPixels + 1:numPixels2, 1, i);
            filtered = reshape(pyr, [56 56]);
            filtered = filtered(:, 5:56-4);
            filtered(filtered < 0) = 0;
        end
        
        
        %filtered = filtered(50-15:50+20, 50-10:50+20);
        
        imagesc(filtered);
        title(['Frame ' int2str(i) ]);
        drawnow;
        pause(0.05);
    end
    return;
end

filtered_stack = ideal_bandpassing(pyr_stack, 3, 1.5, 3, 204);
%{%}
numPixels = 111*111;
for i=1:size(points, 1)

    %pyr = pyr_stack(1:numPixels,1,i);
    pyr = filtered_stack(1:numPixels, 1, i);
    filtered = reshape(pyr, [111 111]);

    %filtered = reconLpyr(pyr_stack(:,1,i),pind);

    filtered(filtered < 0) = 0;
    %filtered = filtered(50-15:50+20, 50-10:50+20);
    imagesc(filtered);
    title(['Frame ' int2str(i) ]);
    drawnow;
    pause(0.02);
end
return;

    %% amplify each spatial frequency bands according to Figure 6 of our paper
    ind = size(pyr_stack(:,1,1),1);
    nLevels = size(pind,1);
    
    alpha = 50;
    lambda_c = 10;
    imgW = 111;
    imgH = 111;
    
    delta = lambda_c/8/(1+alpha);
    
    % the factor to boost alpha above the bound we have in the
    % paper. (for better visualization)
    exaggeration_factor = 2;
    
    % compute the representative wavelength lambda for the lowest spatial 
    % freqency band of Laplacian pyramid
    
    lambda = (imgW^2 + imgH^2).^0.5/3; % 3 is experimental constant

    for l = nLevels:-1:1
      indices = ind-prod(pind(l,:))+1:ind;
      % compute modified alpha for this level
      currAlpha = lambda/delta/8 - 1;
      currAlpha = currAlpha*exaggeration_factor;
          
      if (l == nLevels || l == 1) % ignore the highest and lowest frequency band
          filtered_stack(indices,:,:) = 0;
      elseif (currAlpha > alpha)  % representative lambda exceeds lambda_c
          filtered_stack(indices,:,:) = alpha*filtered_stack(indices,:,:);
      else
          filtered_stack(indices,:,:) = currAlpha*filtered_stack(indices,:,:);
      end
      
      ind = ind - prod(pind(l,:));
      % go one level down on pyramid, 
      % representative lambda will reduce by factor of 2
      lambda = lambda/2; 
    end

    imgSize = [111 111];
    imgCenter = [50-15:50+20, 50-10:50+20];
    % output video
    k = 0;
    for i=2:size(points, 1)
        i
        k = k+1;

        filtered = reconLpyr(filtered_stack(:,1,k),pind);

        img1 = reshape(points(i, 3, :), imgSize);
        filtered(filtered < 0) = 0;
        %filtered = filtered+img1;
        %filtered = filtered(50-15:50+20, 50-10:50+20);
        imagesc(filtered);

        pause(0.02);
        %img2 = reshape(points(i, 4, :), imgSize);
        %filtered = reconLpyr(filtered_stack(:,2,k),pind);

    end
