function [key] = MMM_Key_Function(x, fs)

%y = data(10000:12000); Analyze a portion of the song
Nsamps = length(x);
y_fft = abs(fft(x));
y_fft = y_fft(1:Nsamps/2);
f = fs*(0:Nsamps/2-1)/Nsamps;
%figure(1)
%plot(f,y_fft)
%xlim([0 1000])

% Print out first 20 most common frequencies
%fprintf('The 20 most common frequencies:\n')
for k = 1:20
	note = f(find(y_fft == max(y_fft))); %Find the most frequent pitch
	y_fft(find(y_fft == max(y_fft))) = [];
%	fprintf('%0.0f', note);
    freq(k) = note;
%	fprintf('  ');
end
%fprintf('\n')

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
%fprintf('The notes are:\n')
%disp(half_steps)

%count steps between notes
for k = 2:20
    count(k) = half_steps(k) - half_steps(1);
end
%fprintf('The number of half-steps between notes are:\n')
%disp(count)

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
%    fprintf('The %i most common frequencies:\n',numfrequencies)
    for k = 1:numfrequencies
        note = f(find(y_fft == max(y_fft))); %Find the most frequent pitch
        y_fft(find(y_fft == max(y_fft))) = [];
%        fprintf('%0.0f', note);
        freq(k) = note;
%        fprintf('  ')
    end
%    fprintf('\n')
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
%    fprintf('The notes are:\n')
%    disp(half_steps)
    %count steps between notes
    for k = 2:numfrequencies
        count(k) = half_steps(k) - half_steps(1);
    end
%    fprintf('The number of half-steps between notes are:\n')
%    disp(count)
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
%    disp('The anthem is in a major key.')
    key = {'major'};
elseif any(count==5)==1 && any(count==9)==1
%    disp('The anthem is in a major key.')
    key = {'major'};
elseif any(count==3)==1 && any(count==8)==1
%    disp('The anthem is in a major key.')
    key = {'major'};
elseif any(count==3)==1 && any(count==7)==1
%    disp('The anthem is in a minor key.')
    key = {'minor'};
elseif any(count==5)==1 && any(count==8)==1
%    disp('The anthem is in a minor key.')
    key = {'minor'};
elseif any(count==4)==1 && any(count==9)==1
%    disp('The anthem is in a minor key.')
    key = {'minor'};

end

%determine skewness
%skew = skewness(y_fft)
%figure(2)
%histfit(y_fft)

end