function show_filtered(points, filtered, index)

dim = size(points);

maxLim = max(max(max(filtered(:,index,:))));
minLim = min(min(min(filtered(:,index,:))));
minLim = 0;
lim = [minLim maxLim]
for i = 1:dim(1)  
    img = zeros(110, 110);

    for k = 1:dim(3)
        x = points(i, 1, k) - 290 + 1;
        y = points(i, 2, k) - 190 + 1;

        if x == 50 && y == 30
            %display(k);
        end
        img(x, y) = filtered(i, index, k);
    end
    
    %img(img < 0.0)=0;
    %img(img == 0.0)=30;
    %img(50, 50) = 30;
    img = img(50-20:50+20, 50-10:50+10);
    imagesc(img);
    caxis(lim);
    title(['Frame ' int2str(i) ])
    drawnow;
    %pause(0.05)
end

end