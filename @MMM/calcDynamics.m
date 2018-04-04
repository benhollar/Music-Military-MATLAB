function calcDynamics(obj)
% From calculated expression scores, this function assigns our desginated
% "dynamics" keywords to each song.
%
% Inputs:
%   obj: MMM object
%
% Author: Ben Hollar

lowThird  = 0.5*max(obj.evalOutput.expression);
highThird = 0.75*max(obj.evalOutput.expression);

for idx = 1:length(obj.evalOutput.expression)
    
    currentExpression = obj.evalOutput.expression(idx);
    
    if currentExpression < lowThird
        dynamicString = 'Small';
    elseif currentExpression < highThird
        dynamicString = 'Moderate';
    else
        dynamicString = 'Large';
    end
    
    if isempty(obj.evalOutput.dynamics)
        obj.evalOutput.dynamics = {dynamicString};
    else
        obj.evalOutput.dynamics = [obj.evalOutput.dynamics; dynamicString];
    end
    
end