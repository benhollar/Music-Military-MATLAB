function calcKey(obj, fileName)
% This function attempts to guess what key a song is based on harmonic
% intervals. Results are either 'major' or 'minor'
%
% Inputs:
%   obj: MMM object
%   fileName: filename of MP3 file to analyze
%
% Author: Meghan Zuelke (adapted by Ben Hollar)

[x, fs] = audioread(fileName);

Nsamps = length(x);
y_fft = abs(fft(x));
y_fft = y_fft(1:Nsamps/2);
f = fs*(0:Nsamps/2-1)/Nsamps;

% Print out first 20 most common frequencies
for k = 1:20
	note = f(find(y_fft == max(y_fft))); %Find the most frequent pitch
	y_fft(find(y_fft == max(y_fft))) = [];
    freq(k) = note;
end

%convert frequencies into notes - number of half steps away from A = 440 Hz
fo = 440; %reference frequency
for m = 1:20
    half_steps(m) = round((log(freq(m)/fo))/log(2^(1/12)),0);
    while half_steps(m)<0 %to prevent negative notes
        half_steps(m) = half_steps(m)+12;
    end
    while half_steps(m)>=12 %to keep notes in one 12 numbered range
        half_steps(m) = half_steps(m)-12;
    end
end
half_steps = sort(half_steps); %order the notes

%count steps between notes
for k = 2:20
    count(k) = half_steps(k) - half_steps(1);
end

%print more frequencies if a key cannot be determined from current
%frequencies
numfrequencies = 20;
%find the combination of half-steps that can be used to determine key
Threes = any(count==3);
Fours = any(count==4);
Fives = any(count==5);
Sevens = any(count==7);
Eights = any(count==8);
Nines = any(count==9);
while Threes+Sevens<=1 && Fives+Eights<=1 && Fours+Nines<=1 && Fours+Sevens<=1 && Fives+Nines<=1 && Threes+Eights<=1 
    numfrequencies = numfrequencies+10;
    for k = 1:numfrequencies
        note = f(find(y_fft == max(y_fft))); %Find the most frequent pitch
        y_fft(find(y_fft == max(y_fft))) = [];
        freq(k) = note;
    end
    %convert frequencies into notes - number of half steps away from A = 440 Hz
    fo = 440; %reference frequency
    for m = 1:numfrequencies
        half_steps(m) = round((log(freq(m)/fo))/log(2^(1/12)),0);
        while half_steps(m)<0 %to prevent negative notes
            half_steps(m) = half_steps(m)+12;
        end
        while half_steps(m)>=12 %to keep notes in one 12 numbered range
            half_steps(m) = half_steps(m)-12;
        end
    end
    half_steps = sort(half_steps); %order the notes
    %count steps between notes
    for k = 2:numfrequencies
        count(k) = half_steps(k) - half_steps(1);
    end
    %recalculate the logicals that are used for the while condition
    Threes = any(count==3);
    Fours = any(count==4);
    Fives = any(count==5);
    Sevens = any(count==7);
    Eights = any(count==8);
    Nines = any(count==9);
end

%determine key based on half-steps present
if any(count==4)==1 && any(count==7)==1
    key = 'major';
elseif any(count==5)==1 && any(count==9)==1
    key = 'major';
elseif any(count==3)==1 && any(count==8)==1
    key = 'major';
elseif any(count==3)==1 && any(count==7)==1
    key = 'minor';
elseif any(count==5)==1 && any(count==8)==1
    key = 'minor';
elseif any(count==4)==1 && any(count==9)==1
    key = 'minor';
end

if isempty(obj.evalOutput.key)
    obj.evalOutput.key = {key};
else
    obj.evalOutput.key = [obj.evalOutput.key; key];
end

end