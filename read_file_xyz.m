function [listXYZ] = read_file_xyz(filePath)
% Liest die Punktenwolke ein.
% Gibt XY des Aufnahmepunktes und XYZ des Objektpunktes zurück.

fileData = importdata(filePath, ' ', 2);

listXYZ = zeros(5, size(fileData.data, 1));

% XY
listXYZ(1, :) = fileData.data(:, 1);
listXYZ(2, :) = fileData.data(:, 2);
% XYZ
listXYZ(3, :) = fileData.data(:, 3);
listXYZ(4, :) = fileData.data(:, 4);
listXYZ(5, :) = fileData.data(:, 5);

end