% scan lines in picture
function lines = scanLines(picture)

% create array to store pixels
[height, width] = size(picture);
horizontal = zeros(height, 1);

% scan and calculate the number of black pixels in every line
for i = 1:height
    result = 0;
    for j = 1:width
        if picture(i, j) == 0
            result = result + 1;
        end
    end
    horizontal(i) = result;
end

% cut off lines from picture
expectation = mean(horizontal);
sigma = sqrt(std(horizontal));

lines = [];
i = 1;
while i < height
    if horizontal(i) >= expectation
        first = i;
        while i < height && horizontal(i) >= expectation - sigma * 3
            i = i + 1;
        end
        last = i;
        lines = [lines; [max(first - 5, 1), min(last + 5, height)]];
    end
    i = i + 1;
end