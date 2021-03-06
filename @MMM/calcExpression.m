function calcExpression(obj, fileName)
% This function calculates an expression "score", based upon a mixture of
% sharp dynamic changes, gradual dynamic changes, and overall dynamic
% range. Higher values are more expressive.
%
% Inputs:
%   obj: MMM object
%   fileName: filename of MP3 file to analyze
%
% Author: Ben Hollar

%% Startup
if isempty(obj.currentSong) || ~strcmp(obj.currentSong.name, fileName)
    obj.currentSong(1).name = fileName;
    [obj.currentSong.x, obj.currentSong.fs] = audioread(fileName);
end
x = obj.currentSong.x;
fs = obj.currentSong.fs;

x = x(:, 1);                                  % get the first channel
N = length(x);                                % signal length
t = (0:N-1)/fs;                               % time vector
X = mag2db(abs(nonzeros(x))); X = rot90(X);   % creates vector X of dB values for whole song

%% Dynamic Range of Raw Data
maxval = max(x);
minval = min(x);
dynamicRange = mag2db(maxval/min(abs(nonzeros(x))));

%% Startup 
interval   = .5;%seconds
chunks     = 10;
chunkTime  = max(t) / chunks;
trimLength = 3 / interval; %will be used to trim off sharp drop at ends of songs

n = 1;
for k = 1:length(t)
    if mod(t(k),interval) == 0 && k < length(X); %each (interval) seconds, record what time entry in t that matches to
        newT(n) = k;
        n = n + 1;
    end
end

%% Creates Smoothed Data Line of dB values -- figure 2
n = 1; 
for k = 1:length(newT)-trimLength
    if k > 1
        maxSong(n) = max(X(newT(k-1):newT(k)));
        n = n + 1;
    elseif k == 1
        maxSong(n) = max(X(newT(1:newT(k))));
    end
end


%% Dynamic Range of Smoothed Data
rangeMax  = max(maxSong) - min(maxSong);
highdB = max(maxSong);
lowdB = min(maxSong);
avgdB = mean(maxSong);


%% Locates Large Shifts in dB 
count_soft2loud = 0;
count_loud2soft = 0;
m = 1;
n = 1;

for k = 2:length(maxSong)
   if maxSong(k) - maxSong(k-1) > 0.5*rangeMax
       count_soft2loud = count_soft2loud + 1;
       location_soft2loud(n) = k;
       n = n + 1;
   elseif maxSong(k) - maxSong(k-1) < -0.25*rangeMax
       count_loud2soft = count_loud2soft + 1;
       location_loud2soft(m) = k;
       m = m + 1;
   end
end

if count_soft2loud ~= 0
   soft2loud = t(newT(location_soft2loud));
end
if count_loud2soft ~= 0
   loud2soft = t(newT(location_loud2soft));
end

%% Calculates Mean dB Over Longer Intervals
n = 1;
prevK = 1;
for k = round(length(maxSong)/chunks):round(length(maxSong)/chunks):length(maxSong)
    if k > 1
        mean_over_interval(n) = mean(maxSong(prevK:k)); %time = prevChunk --> currentChunk
        n = n + 1;
    elseif k == 1
        mean_over_interval(n) = mean(maxSong(1:k)); %time = 0 --> chunk1
        n = n + 1;
    end
    prevK = k;
end
if k + round(length(maxSong)/chunks) > length(maxSong)  &&  length(maxSong) - k > 0.3*round(length(maxSong)/chunks)
   mean_over_interval(n) = mean(maxSong(k:length(maxSong))); %time = nextToLastChunk --> end
end

%% Polyfitting -- Trends For Song (i.e decrescendo, crescendo)%%%%%%%%%%%%%%%
x       = 1:length(maxSong);
[poly,~,mu]    = polyfit(x,maxSong,10);
polyAns = polyval(poly,(x-mu(1)) / mu(2));

decreasing = zeros(1,length(maxSong));
increasing = decreasing;
for k = 2:length(polyAns)
    if polyAns(k - 1) < polyAns(k)
        increasing(k) = polyAns(k);
    end
    if polyAns(k - 1) > polyAns(k)
        decreasing(k) = polyAns(k);
    end
end
r = 1;
decreasing_interval = zeros(length(maxSong));
increasing_interval = zeros(length(maxSong));
for k = 2:length(decreasing)
    if decreasing(k) ~= 0
        decreasing_interval(r,k) = decreasing(k);
    end
    if decreasing(k) == 0 && sum(decreasing_interval(r,:)) ~= 0
        r = r + 1;
    end
end
r = 1;
for k = 2:length(increasing)
    if increasing(k) ~= 0
        increasing_interval(r,k) = increasing(k);
    end
    if increasing(k) == 0 && sum(increasing_interval(r,:)) ~= 0
        r = r + 1;
    end
end


[rows,cols] = size(decreasing_interval);
r   = 1;
c   = 1;
r1  = 1;
c1  = 1;
for row = 1:rows
    %Decreasing Locations
    for col = 3:cols
        if decreasing_interval(row,col-1) == 0 && decreasing_interval(row,col) ~= 0
            decreasing_location(r,c) = t(newT(col));
            c = c + 1;
        end
        if decreasing_interval(row,col-1) ~= 0 && decreasing_interval(row,col) == 0
            decreasing_location(r,c) = t(newT(col));
            r = r + 1;
            c = 1;
        end
    end
    %Increasing Locations
    for col = 3:cols
        if increasing_interval(row,col-1) == 0 && increasing_interval(row,col) ~= 0
            increasing_location(r1,c1) = t(newT(col));
            c1 = c1 + 1;
        end
        if increasing_interval(row,col-1) ~= 0 && increasing_interval(row,col) == 0
            increasing_location(r1,c1) = t(newT(col));
            r1 = r1 + 1;
            c1 = 1;
        end
    end    
end

[rows,cols]   = size(decreasing_location);
[rows1,cols1] = size(increasing_location);

%Fix Location Matrices
if decreasing_location(1,2) == 0
    decreasing_location(1,2) = decreasing_location(1,1);
    decreasing_location(1,1) = 0;
end
if increasing_location(1,2) == 0
    increasing_location(1,2) = increasing_location(1,1);
    increasing_location(1,1) = 0;
end
if decreasing_location(rows,cols) == 0
    decreasing_location(rows,cols) = t(length(t));
end
if increasing_location(rows1,cols1) == 0
    increasing_location(rows1,cols1) = t(length(t));
end

%% SCORING -- probably needs tweaked

score = count_loud2soft + count_soft2loud;                                     %sharp dynamic changes
score = score + rangeMax;                                                      %dynamic range
score = score + avgdB-min(mean_over_interval) + max(mean_over_interval)-avgdB; %deviance in softest / loudest sections
score = score + abs((length(find(mean_over_interval > avgdB))) - (length(find(mean_over_interval < avgdB))));  %sections louder - sections quieter
[r,~] = size(decreasing_location); 
score = score + r;                 %number of decreasing intervals
[r,~] = size(increasing_location);
score = score + r;                 %number of increasing intervals

if isempty(obj.evalOutput)
    obj.evalOutput(1).expression{1} = score;
else
    obj.evalOutput.expression = [obj.evalOutput.expression; score];
end

end