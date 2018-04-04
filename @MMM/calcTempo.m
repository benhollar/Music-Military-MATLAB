function calcTempo(obj, fileName)
% This function generates a number that correlates with the "tempo" of the
% song, based on how much motion the song has
%
% Inputs
%   obj: MMM object
%   filename: filename of MP3 file to analyze
%
% Author: Brennan Thomas (adapted by Ben Hollar)

% Read the audio file and extract the first channel
if isempty(obj.currentSong) || ~strcmp(obj.currentSong.name, fileName)
    obj.currentSong(1).name = fileName;
    [obj.currentSong.x, obj.currentSong.fs] = audioread(fileName);
end
d = obj.currentSong.x;
sr = obj.currentSong.fs;
d = d(:,1);

% Use the library to detect possible tempos
tempo = tempo2(d,sr);

% Compare the tempo values and select the most likely tempo
if tempo(3) > .5
    tempo = tempo(1);
else
    tempo = tempo(2);
end

if isempty(obj.evalOutput)
    obj.evalOutput(1).tempo = tempo;
else
    obj.evalOutput.tempo = [obj.evalOutput.tempo; tempo];
end

end



