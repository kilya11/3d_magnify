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

        zNorm = interp1(x1, z1, x);

        pointsNorm(i, index, :) = zNorm(sort2index(index, :));
    end
end
%return;

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