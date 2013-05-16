%
% Spatial Filtering: Gaussian blur and down sample
% Temporal Filtering: Ideal bandpass
% 

    alpha = 50;
    level = 1;
                 



    % compute Gaussian blur stack
    disp('Spatial filtering...')
    Gdown_stack = build_GDown_stack(points(:, :, :), level);
    disp('Finished')
    
    
    
    % Temporal filtering
    disp('Temporal filtering...')
    filtered_stack = ideal_bandpassing(Gdown_stack, 1, 1.5, 3, 204);
    
    disp('Finished')
    
    %% amplify
    filtered_stack(:,:,:,1) = filtered_stack(:,:,:,1) .* alpha;
    filtered_stack(:,:,:,2) = filtered_stack(:,:,:,2) .* alpha;



    %% Render on the input video
    disp('Rendering...')
    index = 1;
    maxLim = max(max(max(filtered_stack(:,:,:,index))));
    minLim = min(min(min(filtered_stack(:,:,:,index))));
    minLim = 0;
    lim = [minLim maxLim]

    % output video
    imgSize = [111 111];
    k = 0;
    for i=1:size(points, 1)
        k = k+1;

        img1 = reshape(points(i, 3, :), imgSize);

        filtered = squeeze(filtered_stack(k,:,:,1));

        filtered = imresize(filtered,imgSize);
        
        %filtered = filtered+img1;
        %filtered = filtered(50-15:50+20, 50-10:50+20);
        %minPositive = min(min(filtered(filtered > 0)));
        %filtered(filtered == 0) = minPositive;
        %filtered(filtered < 0) = 0;
        imagesc(filtered);
        caxis(lim);
        title(['Frame ' int2str(i) ])
        %colorbar
        drawnow;
        pause(0.02);
    end

    disp('Finished')

