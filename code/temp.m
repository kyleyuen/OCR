addpath('functions');

% Load the weights into variables Theta1 and Theta2
load('../data/weights.mat');

characters = scanImage('/home/kyle/Pictures/Selection_001.png');

pic = [];
for i = 1:length(characters)
    pic = [pic; characters(i).image];
end
displayData(pic);

characters = recognizeCharacters(Theta1, Theta2, characters);
text = constructText(characters);

for i = 1:length(text)
    for j = 1:length(text{i})
        text{i}{j} = spellCheck(text{i}{j});
    end
end

printText(text);