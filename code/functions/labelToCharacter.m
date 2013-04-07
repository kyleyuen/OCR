function c = labelToCharacter(index)
% labelToCharacter recieve a label
% and return correspondence character

    if index < 10
        c = '0' + index;
    elseif index == 10
        c = '0';
    elseif index <= 36
        c = 'A' + index - 11;
    elseif index <= 62
        c = 'a' + index - 37;
    end