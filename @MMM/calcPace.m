function calcPace(obj)
% From calculated tempos, this function will assign our designated "pace"
% keywords to each song.
%
% Inputs:
%   obj: MMM object
%
% Author: Ben Hollar

for idx = 1:length(obj.evalOutput.tempo)
    
    currentTempo = obj.evalOutput.tempo(idx);
    
    if currentTempo < 70
        paceString = 'Slow';
    elseif currentTempo < 100
        paceString = 'Moderate';
    else
        paceString = 'Fast';
    end
    
    if isempty(obj.evalOutput.pace)
        obj.evalOutput.pace = {paceString};
    else
        obj.evalOutput.pace = [obj.evalOutput.pace; paceString];
    end
    
end