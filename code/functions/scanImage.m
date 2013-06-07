% scan then given image to analysis character position in the image
function characters = scanImage(path)

% load the picture and transfer it to black and white
picture = imread(path);
picture = rgb2gray(picture);
level = graythresh(picture);
picture = im2bw(picture, level);

% scan lines in picture
lines = scanLines(picture);

% display lines
% for i = 1:length(lines)
%     figure(i);
%     imshow(picture(lines(i, 1):lines(i, 2), :));
% end

% scan characters in lines
characters = scanCharacters(picture, lines);

% display characters
% pic = [];
% for i = 1:length(characters)
%     pic = [pic; characters(i).image];
% end
% figure(100);
% displayData(pic);