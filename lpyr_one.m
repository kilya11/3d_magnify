addpath('./matlabPyrTools');

img = img0;
[pyr, pind] = buildLpyr(img, 'auto');

for lambda_c = 200:500
    
imgFilter = pyr;

    %% amplify each spatial frequency bands according to Figure 6 of our paper
    ind = size(pyr,1);
    nLevels = size(pind,1);
    
    alpha = 50;
    %lambda_c = 50;
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
          imgFilter(indices) = 0;
          display('ignore');
      elseif (currAlpha > alpha)  % representative lambda exceeds lambda_c
          imgFilter(indices) = alpha*imgFilter(indices);
          display('alpha');
      else
          imgFilter(indices) = currAlpha*imgFilter(indices);
          display('currAlpha');
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
    for i=1:1
        
        k = k+1;

        filtered = reconLpyr(imgFilter,pind);

        img1 = reshape(points(i, 3, :), imgSize);
        %filtered(filtered < 0) = 0;
        %filtered = filtered+img;
        %filtered = filtered(50-15:50+20, 50-10:50+20);
        imagesc(filtered);
        %mesh(filtered);

        title(['Frame ' int2str(lambda_c) ])
        drawnow;
    
        pause(0.1);
        %img2 = reshape(points(i, 4, :), imgSize);
        %filtered = reconLpyr(filtered_stack(:,2,k),pind);
    end
end;