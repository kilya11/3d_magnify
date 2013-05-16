function [ listRes ] = mask_image( listXYZ )
% Liefert die Koordinaten des Bildes.
% Schneidet den wichtigen Bereich aus.
% Unbestimmte Positionen werden aus dem vorherigen Bild genommen.

% Ein Bereich mit relevanten Daten.
cutXmin = 290;
cutXmax = 400;

cutYmin = 190;
cutYmax = 300;

dim = size(listXYZ);
x = listXYZ(1, :);
y = listXYZ(2, :);

mask = x >= cutXmin & x <= cutXmax & y >= cutYmin & y <= cutYmax;
mask = repmat(mask, [dim(1) 1]);

listXYZ(~mask) = 0;
listMask = listXYZ(:, any(listXYZ));

elementsNum = (cutXmax - cutXmin) * (cutYmax - cutYmin);

global last_mask;

firstInit = false;
if isempty(last_mask)
    last_mask = zeros(dim(1), elementsNum);
    firstInit = true;
end;    

listRes = last_mask;

x = listMask(1, :);
y = listMask(2, :);

index = 1;
for ix = cutXmin:cutXmax
    for iy = cutYmin:cutYmax
        i = find(x == ix & y == iy, 1);
        
        if ~isempty(i)
            listRes(:, index) = listMask(:, i);
        elseif firstInit
            listRes(:, index) = [ix; iy; NaN; NaN; NaN];
        end
        
        index = index + 1;
    end
end

last_mask = listRes;
end

