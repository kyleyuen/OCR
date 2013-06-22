% do a very simple spell check for a single word
function word = spellCheck(word)

containDigit = 0;
containUpper = 0;
containLower = 0;

for i = 1:length(word)
    if '0' <= word(i) && word(i) <= '9'
        containDigit = 1;
    elseif 'A' <= word(i) && word(i) <= 'Z'
        containUpper = 1;
    elseif 'a' <= word(i) && word(i) <= 'z'
        containLower = 1;
    end
end

if (containUpper == 1 || containLower == 1) && containDigit == 1
    for i = 1:length(word)
        if word(i) == '0'
            word(i) = 'o';
        end
    end
end

if containUpper == 1 && containLower == 1
    for i = 1:length(word)
        if 'A' <= word(i) && word(i) <= 'Z'
            if word(i) == 'C'
                word(i) = 'c';
            elseif word(i) == 'O'
                word(i) = 'o';
            elseif word(i) == 'S'
                word(i) = 's';
            end
        end
    end
end