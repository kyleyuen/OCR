% analysis character position in the image
function characters = scanCharacters(picture, lines)

% create array to store pixels
width = size(picture, 2);

characters = [];

for k = 1:size(lines, 1)
    first = lines(k, 1);
    last = lines(k, 2);

    vertical = zeros(width, 1);
    % scan and calculate the number of black pixels in every column
    for j = 1:width
        result = 0;
        for i = first:last
            if picture(i, j) == 0
                result = result + 1;
            end
        end
        vertical(j) = result;
    end
    
%     figure(k);
%     bar(vertical);
    % scan words in this line
    words = scanWords(vertical);
    
    for i = 1:size(words, 1)
        position = analysisWords(picture, lines(k, :), words(i, :));
        
        n = size(position, 1);
        temp = struct('image', cell(n, 1), 'index', 0, 'line', k, 'word', i);
        for j = 1:n
            image = picture(lines(k, 1):lines(k, 2), position(j, 1):position(j, 2));
            image = frameImage(image);
            if ~isempty(image)
                image = image(:)';
                temp(j).image = image;
                characters = [characters; temp(j)];
            end
        end
    end
end