function image = frameImage(image)

standardHeight = 24;
standardWidth = 24;
standardHeightRatio = 0.6;
standardWidthRatio = 0.6;

% process top to bottom
[height, width] = size(image);
top = 1;
bottom = height;
for i = 1:height
    if all(image(i, :)) == 0
        top = i;
        break;
    end
end
for i = height:-1:1
    if all(image(i, :)) == 0
        bottom = i;
        break;
    end
end

image = image(top:bottom, :);
effectiveHeight = bottom - top + 1;
if effectiveHeight < 8
    image = [];
    return;
end

targetHeight = int8(effectiveHeight / standardHeightRatio);
buffer = ones(int8((targetHeight - effectiveHeight) / 2), width);
image = [buffer; image; buffer];

% process left to right
[height, width] = size(image);
left = 1;
right = width;
for j = 1:width
    if all(image(:, j)) == 0
        left = j;
        break;
    end
end
for j = width:-1:1
    if all(image(:, j)) == 0
        right = j;
        break;
    end
end

image = image(:, left:right);
effectiveWidth = right - left + 1;

if effectiveWidth < 6
    standardWidthRatio = 0.25;
end
targetWidth = int8(effectiveWidth /  standardWidthRatio);
buffer = ones(height, int8((targetWidth - effectiveWidth) / 2));
image = [buffer, image, buffer];

% resize the image to stardard size
image = imresize(image, [standardHeight, standardWidth]);