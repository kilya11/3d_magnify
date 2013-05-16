function [ imgL, imgR ] = mask_image( cameraL, cameraR )
%Liefert das Bild und korrespondiertes Bild
%   Schneidet den wichtigen Bereich aus,
%   baut die Bilder auf

x = cameraL(:, 1);
mask = x >= 290 & x <= 400;
x(~mask) = 0;

y = cameraL(:, 2);
mask = y >= 190 & y <= 300;
y(~mask) = 0;

factor = 5;
cameraR = round(cameraR*factor);

imgL = zeros(max(x), max(y));
imgR = zeros(max(cameraR(:, 1)), max(cameraR(:, 2)));

for i = 1:size(x, 1)
    if x(i) && y(i)
        imgL(x(i), y(i)) = 1;
        imgR(cameraR(i, 1), cameraR(i, 2)) = 1;
    end
end    

imgL = imgL(290:400, 190:300);
imgR = imgR(140*factor:260*factor, 220*factor:350*factor);

end

