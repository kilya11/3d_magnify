if 0
    t = points(10, 3, :);
    t = reshape(t, imgDim);
    for i = 1:7
        i
        row = t(i,:);
        plot(row)
        drawnow;
        pause(0.1)
    end
    
    t2 = pointsNorm(10, 3, :);
    t2 = reshape(t2, imgDim);
    row2 = t2(i,:);
    
    figure(1);
    clf reset;
    colormap gray;
    subplot(2, 1, 1);
    plot(row, 'k')
    xlabel('x von 1. Kamera')
    ylabel('x von 2. Kamera')
    
    subplot(2, 1, 2);
    plot(row2, 'k')
    xlabel('x von 1. Kamera')
    ylabel('x von 2. Kamera')
    return;
end

pointsNorm = points;

sortBase = zeros(size(pointsNorm, 2), size(pointsNorm, 3));
index2sort = sortBase;
sort2index = sortBase;

xList = points(1, 1, :);
xList = squeeze(xList);

yList = points(1, 2, :);
yList = squeeze(yList);

sortBase(3, :) = xList * max(yList) + yList;
sortBase(4, :) = yList * max(xList) + xList;

for i = 1:size(sortBase, 1)
    [~, indices] = sort(sortBase(i, :));
    index2sort(i, :) = squeeze(indices);

    [~, indices] = sort(index2sort(i, :));
    sort2index(i, :) = squeeze(indices);
end

if 1
for i = 1:size(pointsNorm, 1)
    for index = 3:4
        z = points(i, index, :);
        z = squeeze(z);
        z = z(index2sort(index, :));
    
        x = 1:size(z);
        mask = (isnan(z));

        z1 = z;
        z1(mask) = [];
        
        x1 = x;
        x1(mask) = [];

        p = polyfit(x1', z1, 1);
        zTrend = polyval(p, x1');
        zNorm = z1 - zTrend;
        diff = 2*std(zNorm);
        mask = abs(zNorm) > diff;
        x1(mask) = [];
        z1(mask) = [];

        zNorm = interp1(x1, z1, x, 'nearest', 'extrap');

        pointsNorm(i, index, :) = zNorm(sort2index(index, :));
    end
end
%return;
end

pointsNorm2 = points;

for i = 1:size(pointsNorm2, 1)
    for index = 3:4
        z = points(i, index, :);
        z = squeeze(z);
        z = z(index2sort(index, :));
        
        z1 = z;
        x = 1:size(z);
        
        mask = (isnan(z));
        z1(mask) = [];

        x1 = x;
        x1(mask) = [];
        
        p = polyfit(x1', z1, 1);

        zTrend = polyval(p, x');

        zNorm = z - zTrend;

        pointsNorm2(i, index, :) = zNorm;
    end
end

