pointsNorm = points;

for i = 1:size(points, 1)
    y = points(i, 3, :);
    y = squeeze(y);
    
    y1 = y;
    mask = (y == 0);
    y1(mask) = [];

    x = 1:size(y);
    x1 = x;
    x1(mask) = [];

    yNorm = interp1(x1, y1, x);
    
    pointsNorm(i, 3, :) = yNorm;
end
%return;
pointsNorm2 = pointsNorm;

for i = 1:size(pointsNorm, 1)
    y = pointsNorm(i, 3, :);
    y = squeeze(y);
    
    %y1 = y;
    %mask = (y == 0);
    %y1(mask) = [];

    x = 1:size(y);
    x = x';
    
    p = polyfit(x, y, 1);
    
    yTrend = polyval(p, x);

    yNorm = y - yTrend;
    
    pointsNorm2(i, 3, :) = yNorm;
end