pred = predict(Theta1, Theta2, trainData);

n = size(pred, 1);
index = [];
for i = 1:n
    if (pred(i) == -1)
        index = cat(2, index, i);
    end
end
trainData(index, :) = [];
trainLabel(index, :) = [];

save '../data/train.mat' trainData trainLabel