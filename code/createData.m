direction = '../trainingSet/rawData/pictures/';

% get folders info under raw data directions
folders = dir(direction);
%folders = setdiff({folders.name},{'.','..'});
numFolders = length(folders);

trainData = [];
trainLabel = [];
crossValidationData = [];
crossValidationLabel = [];
testData = [];
testLabel = [];

for i = 3:numFolders 
    path = strcat(direction, folders(i).name, '/');
    pngFiles = dir(strcat(path, '*.png'));
    numFiles = length(pngFiles);
    index = eval(folders(i).name(7:9));
    
    % create train data
    result = [];
    for j = 1:numFiles
        temp = imread(strcat(path, pngFiles(j).name));
        level = graythresh(temp);
        temp = im2bw(temp, level);
        result = cat(1, result, temp(:)');
    end
    trainData = cat(1, trainData, result);
    labels = ones(numFiles, 1) * index;
    trainLabel = cat(1, trainLabel, labels);
end

save '../data/train.mat' trainData trainLabel