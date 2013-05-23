function printCharacters(characters)

fprintf('%c', labelToCharacter(characters(1).index));
for i = 2:size(characters, 1)
    if characters(i).word ~= characters(i - 1).word
        fprintf(' ');
    end
    if characters(i).line ~= characters(i - 1).line
        fprintf('\n');
    end
    fprintf('%c', labelToCharacter(characters(i).index));
end
fprintf('\n');