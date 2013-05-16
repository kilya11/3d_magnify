points2 = points(1:30, :, :);

index = 3;
indexF = 1;

factor = 5;
y1 = zeros(30);
y2 = zeros(30);
for i = 1:30
    img = zeros(110, 110);
    shown = false;
    
    for k = 1:minDim
        x = points(i, 1, k) - 290 + 1;
        y = points(i, 2, k) - 190 + 1;
        
        diffY = 0;
        if filtered(i, 3, k) > 0.0
            diffY = points(i, 5, k) - points(i - 1, 5, k);
            points2(i, 5, k) = points(i, 5, k) + factor*diffY;
            if ~shown && x > 50 && y > 20
                display([x y]);
                shown = true;
            end;
        end;
        
        img(x, y) = points(i, 5, k) + factor*diffY;
        if x == 30 && y == 35
            y1(i) = points(i, 5, k);
            y2(i) = img(x, y);
            img(x, y) = 1;
        end;
    end
    
    %img(img < 0.02)=0;
    imagesc(img);
    title(['Frame ' int2str(i) ])
    drawnow;
    pause(0.2)
end
m = points2(1, :, :);
m = squeeze(m);
m = m.';
dlmwrite('..\data\magnified_data.txt', m, 'delimiter', ' ', 'newline', 'pc');