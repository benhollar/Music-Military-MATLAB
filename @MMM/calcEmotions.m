function calcEmotions(obj)
% Using a composite of our calculated pace, key, and dynamics, we can
% calculate an "emotion" of each song. See the research poster for more
% information.
%
% Inputs:
%   obj: MMM object
%
% Author: Ben Hollar

flowchartEmotions = {'Animated','Joyful','Strong','Triumphant','Heroic',...
    'Relaxed','Inspired','Transcendant','Dreamy'; 'Tense','Irritated',...
    'Nervous','Agitated','Impatient','Nervous','Sorrowful','Sad','Melancholy'};

Key = obj.evalOutput.key;
Pace = obj.evalOutput.pace;
Dynamics = obj.evalOutput.dynamics;

for k = 1:length(Key)
    %% a bunch of if statements to go through the flowchart, narrowing possible emotions
    
    if strcmp(Key(k), {'major'})
        possibleEmotions = flowchartEmotions(1,:);
    else
        possibleEmotions = flowchartEmotions(2,:);
    end
    
    if strcmp(Pace(k), {'Fast'})
        possibleEmotions = possibleEmotions(1,1:3);
    elseif strcmp(Pace(k), {'Moderate'})
        possibleEmotions = possibleEmotions(1,4:6);
    else
        possibleEmotions = possibleEmotions(1,7:9);
    end
    
    if strcmp(Dynamics(k), {'Large'})
        possibleEmotions = possibleEmotions(1,1);
    elseif strcmp(Dynamics(k), {'Moderate'})
        possibleEmotions = possibleEmotions(1,2);
    else
        possibleEmotions = possibleEmotions(1,3);
    end
           
    %% Store determined emotion / reset for next loop
    if isempty(obj.evalOutput.emotion)
        obj.evalOutput.emotion = possibleEmotions(1,1);
    else
        obj.evalOutput.emotion = [obj.evalOutput.emotion; possibleEmotions(1,1)];
    end
    
end

end