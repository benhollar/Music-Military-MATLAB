function [tempo] = MMM_Tempo_Function(fileName)
% Created by Brennan Thomas
% This function generates a number that correlates with the "tempo" of the
% song, based on how much motion the song has
% This requires the associated libraries: tempo2.m, fft2melmx.m

% Read the audio file and extract the first channel
[d,sr] = audioread(fileName);
d = d(:,1);

% Use the library to detect possible tempos
tempo = tempo2(d,sr);

% Compare the tempo values and select the most likely tempo
if tempo(3) > .5
    tempo = tempo(1);
else
    tempo = tempo(2);
end

% Display the tempo
%fprintf('Overall Tempo: %f\n', tempo);

end

