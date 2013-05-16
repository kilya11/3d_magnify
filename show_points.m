function show_points(points, index)

dim = size(points);

maxLim = max(max(max(points(:,index,:))));
minLim = min(min(min(points(:,index,:))));

% Skalierung fürs Colorbar
lim = [minLim maxLim];
for i = 1:dim(1)  
    img = zeros(110, 110);

    for k = 1:dim(3)
        x = points(i, 1, k) - 290 + 1;
        y = points(i, 2, k) - 190 + 1;
        if x == 50 && y == 30
            %display(k);
        end
        img(x, y) = points(i, index, k);
    end
    
    %img(50, 30) = 1;
    imagesc(img);
    caxis(lim);
    title(['Frame ' int2str(i) ])
    drawnow;
    %pause(0.05)
end

end