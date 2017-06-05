function [Emotions] = MMM_Emotions_Function( Key, Pace, Dynamics )

Emotions = cell(21,1);
flowchartEmotions = {'Animated','Joyful','Strong','Triumphant','Heroic','Relaxed','Inspired','Transcendant','Dreamy'; 'Tense','Irritated','Nervous','Agitated','Impatient','Nervous','Sorrowful','Sad','Melancholy'}

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
    Emotions(k,1) = possibleEmotions(1,1);
    possibleEmotions = flowchartEmotions;
end


end