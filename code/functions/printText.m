% print text to standard output
function printText(text)

for i = 1:length(text)
    for j = 1:length(text{i})
        fprintf('%s ', text{i}{j});
    end
    fprintf('\n');
end
fprintf('\n');