% construct whole text by using characters
function text = constructText(characters)

text = {};
line = {};
word = '';

word = strcat(word, labelToCharacter(characters(1).index));
for i = 2:length(characters)
    if characters(i).word ~= characters(i - 1).word
        line = [line, word];
        word = '';
    end
    if characters(i).line ~= characters(i - 1).line
        if ~isempty(word)
            line = [line, word];
            word = '';
        end
        text = [text, {line}];
        line = {};
    end
    word = strcat(word, labelToCharacter(characters(i).index));
end
line = [line, word];
text = [text, {line}];