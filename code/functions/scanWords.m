% scan words in this line
function words = scanWords(vertical)

expectation = int8(mean(vertical));
sigma = int8(sqrt(std(vertical)));

% find blanks in this line
blanks = [];
i = 1;
width = size(vertical, 1);

while i < width
    if vertical(i) < expectation
        first = i;
        while i < width && vertical(i) < sigma * 0.5
            i = i + 1;
        end
        last = i;
        
        if last - first > sigma * 2
            blanks = [blanks; [first, last]];
        end
    end
    i = i + 1;
end

words = [];
for i = 2:size(blanks, 1);
    first = blanks(i - 1, 2);
    last = blanks(i, 1);
    words = [words; [max(first - 5, 1), min(last + 5, width)]];
end