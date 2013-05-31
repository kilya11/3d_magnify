function show_filtered(points, filtered, index)

dim = size(points);

maxLim = max(max(max(filtered(:,index,:))));
minLim = min(min(min(filtered(:,index,:))));
%minLim = 0;
global imgDim;
imgDim = [171 171];
lim = [minLim maxLim]*0.1
difVal = (maxLim - minLim);
for i = 1:dim(1)
    img = reshape(filtered(i, index, :), imgDim);

    %img(img > difVal | img < -difVal) = nan;
    %img(img == 0.0)=30;
    %img(50, 50) = 30;
    %img = img(50-20:50+20, 50-10:50+10);
    imagesc(img);
    %mesh(img);
    %axis([0 120 0 120 minLim maxLim]);
    caxis(lim);
    title(['Frame ' int2str(i) ])
    drawnow;
    pause(0.05)
end

end