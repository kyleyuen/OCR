function [horizontal, vertical] = scanImage(path)

% load the picture
picture = imread(path);
level = graythresh(picture);
picture = im2bw(picture, level);

% create array to store pixels
[height, width] = size(picture);
horizontal = zeros(height, 1);
vertical = zeros(width, 1);

% scan and calculate the number of black pixels in every line
for i = 1:height
    result = 0;
    for j = 1:width
        if picture(i, j) == 1
            result = result + 1;
        end
    end
    horizontal(i) = result;
end