function show_points(points, index)

dim = size(points);

maxLim = max(max(max(points(:,index,:))));
minLim = min(min(min(points(:,index,:))));

colormap gray;
global imgDim;

% Skalierung fürs Colorbar
lim = [minLim maxLim];
for i = 1:dim(1)  
    img = reshape(points(i, index, :), imgDim);

    img(150, 100) = 450;
    %imagesc(img);
    mesh(img);
    %axis([0 120 0 120 minLim maxLim]);
    caxis(lim);
    title(['Frame ' int2str(i) ])
    drawnow;
    %pause(0.05)
end

end