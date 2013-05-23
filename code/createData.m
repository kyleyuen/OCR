addpath('functions');

direction = '../trainingSet/rawData/fonts/';

% get folders info under raw data directions
files = dir(direction);
numFiles = length(files);

trainData = [];
trainLabel = [];

for i = 3:numFiles
    path = strcat(direction, files(i).name)
    characters = scanImage(path);

    result = [];
    for j = 1:length(characters)
        result = [result; characters(j).image];
    end
    figure(i);
    displayData(result);
    if size(result, 1) == 62
        trainData = [trainData; result];
        labels = (1:62)';
        trainLabel = [trainLabel; labels];
    end
end

save '../data/train.mat' trainData trainLabel