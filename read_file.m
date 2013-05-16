% Read point cloud
function [cameraL, cameraR] = read_file(filePath)

%{
file = fopen(filePath, 'r');

% advance the file pointer one line
format = fgetl(file);
if ~ strcmp(format, 'PCF1.0')
	disp('False format: ' + format)
	return
end
fclose(file);
%}
fileData = importdata(filePath, ' ', 2);
cameraL = fileData.data(:, 1:2);
cameraR = fileData.data(:, 3:4);

end