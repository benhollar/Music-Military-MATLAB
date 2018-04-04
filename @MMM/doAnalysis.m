function doAnalysis(obj)
% Do the analysis we performed on each song.
%
% Inputs:
%   obj: MMM object

% Analyze each song for tempo, expression, and key
for idx = 1:length(obj.songList)
    
    currentSong = obj.songList{idx};
    obj.calcTempo(currentSong);
    obj.calcExpression(currentSong);
    obj.calcKey(currentSong);
    
end

% Using information gathered above, we can now calculate dynamics, pace,
% and emotion from each song.
obj.calcDynamics();
obj.calcPace();
obj.calcEmotions();

% This method generates the result table...
obj.generateTable();
% which is then displayed on the command window.
disp(obj.resultTable);

end

