% recognize characters
function characters = recognizeCharacters(Theta1, Theta2, characters)

for i = 1:size(characters, 1)
    characters(i).index = predict(Theta1, Theta2, characters(i).image);
end