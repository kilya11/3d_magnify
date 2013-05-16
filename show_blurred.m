function show_blurred(filtered, index)

dim = size(filtered);

maxLim = max(max(max(filtered(:,index,:))));
%minLim = min(min(min(filtered(:,index,:))));
minLim = 0;
lim = [minLim maxLim]
for i = 1:dim(1)  
    img = reshape(filtered(i, index, :), [56 56]);

    img(img < 0.0)=0;
    
    %img(50, 30) = 1;
    imagesc(img);
    caxis(lim);
    title(['Frame ' int2str(i) ])
    drawnow;
    %pause(0.05)
end

end