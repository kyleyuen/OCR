% analysis characters in the specific area of the picture
function position = analysisWords(picture, rows, columns)
global state

% get positions
top = rows(1, 1) - 1;
bottom = rows(1, 2);
left = columns(1, 1) - 1;
right = columns(1, 2);

height = bottom - top;
width = right - left;

state = zeros(height, width);

% get every characters in the word
position = [];
for j = 1:width
    for i = 1:height
        if state(i, j) == 0 && picture(top + i, left + j) == 0
            rightMost = dfs(i, j, picture, top, left);
            position = [position; [left + j, left + rightMost]];
        end
    end
end

% get rid of duplicate characters
n = size(position, 1);
index = [];
i = n;
while i > 1
    if abs(position(i - 1, 1) - position(i, 1)) <= 6 ...
    && abs(position(i - 1, 2) - position(i, 2)) <= 6
        if abs(position(i - 1, 1) - position(i - 1, 2)) > abs(position(i, 1) - position(i, 2))
            index = [index, i];
        else
            index = [index, i - 1];
        end
    end
    i = i - 1;
end

for i = 1:length(index)
    position(index(i), :) = [];
end


% run dfs in the picture
function rightMost = dfs(i, j, picture, top, left)
global state

state(i, j) = 1;

directions = [ [-1, -1]; [-1, 0]; [-1, 1]; [0, 1]; 
               [1, 1]; [1, 0]; [1, -1]; [0, -1] ];

rightMost = j;
for k = 1:size(directions, 1)
    x = directions(k, 1) + i;
    y = directions(k, 2) + j;

    if x == 0 || x == size(state, 1) + 1
        continue;
    end

    if y == 0 || y == size(state, 2) + 1
        continue;
    end

    if state(x, y) == 0 && picture(top + x, left + y) == 0
        position = dfs(x, y, picture, top, left);
        if rightMost < position
            rightMost = position;
        end
    end
end