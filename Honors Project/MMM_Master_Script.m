%MASTER SCRIPT

clear all; close all; clc; commandwindow;
addpath('MP3 Files');
disp('Running... Please wait. Will take approximately 1-2 minutes.')

%% Tempo / Pace -- Brennan

Tempo(1,1) = MMM_Tempo_Function('us.mp3'); Tempo(2,1) = MMM_Tempo_Function('ru.mp3');
Tempo(3,1) = MMM_Tempo_Function('cn.mp3'); Tempo(4,1) = MMM_Tempo_Function('jp.mp3');
Tempo(5,1) = MMM_Tempo_Function('in.mp3'); Tempo(6,1) = MMM_Tempo_Function('fr.mp3');
Tempo(7,1) = MMM_Tempo_Function('kr.mp3'); Tempo(8,1) = MMM_Tempo_Function('it.mp3');
Tempo(9,1) = MMM_Tempo_Function('gb.mp3'); Tempo(10,1) = MMM_Tempo_Function('tr.mp3');
Tempo(11,1) = MMM_Tempo_Function('cr.mp3'); Tempo(12,1) = MMM_Tempo_Function('ad.mp3');
Tempo(13,1) = MMM_Tempo_Function('dm.mp3'); Tempo(14,1) = MMM_Tempo_Function('gd.mp3');
Tempo(15,1) = MMM_Tempo_Function('ki.mp3'); Tempo(16,1) = MMM_Tempo_Function('li.mp3');
Tempo(17,1) = MMM_Tempo_Function('ca.mp3'); Tempo(18,1) = MMM_Tempo_Function('va.mp3');
Tempo(19,1) = MMM_Tempo_Function('ht.mp3'); Tempo(20,1) = MMM_Tempo_Function('pw.mp3');
Tempo(21,1) = MMM_Tempo_Function('kp.mp3');

%% Dynamics & Key -- Ben / Meghan

Expression = zeros(21,1);
Key = cell(21,1);

%Strong Military

[x, fs] = audioread('us.mp3');
Expression(1,1) = MMM_Dynamics_Function( x, fs, 'United States' );
Key(1,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('ru.mp3');
Expression(2,1) = MMM_Dynamics_Function( x, fs, 'Russia' );
Key(2,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('cn.mp3');
Expression(3,1) = MMM_Dynamics_Function( x, fs, 'China' );
Key(3,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('jp.mp3');
Expression(4,1) = MMM_Dynamics_Function( x, fs, 'Japan' );
Key(4,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('in.mp3');
Expression(5,1) = MMM_Dynamics_Function( x, fs, 'India' );
%Key(5,1) = MMM_Key_Function( x, fs );
Key(5,1) = {'minor'};

[x, fs] = audioread('fr.mp3');
Expression(6,1) = MMM_Dynamics_Function( x, fs, 'France' );
%Key(6,1) = MMM_Key_Function( x, fs );
Key(6,1) = {'major'};

[x, fs] = audioread('kr.mp3');
Expression(7,1) = MMM_Dynamics_Function( x, fs, 'South Korea' );
%Key(7,1) = MMM_Key_Function( x, fs );
Key(7,1) = {'major'};

[x, fs] = audioread('it.mp3');
Expression(8,1) = MMM_Dynamics_Function( x, fs, 'Italy' );
Key(8,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('gb.mp3');
Expression(9,1) = MMM_Dynamics_Function( x, fs, 'UK' );
Key(9,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('tr.mp3');
Expression(10,1) = MMM_Dynamics_Function( x, fs, 'Turkey' );
Key(10,1) = MMM_Key_Function( x, fs );

%Weak Military

[x, fs] = audioread('cr.mp3');
Expression(11,1) = MMM_Dynamics_Function( x, fs, 'Costa Rica' );
Key(11,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('ad.mp3');
Expression(12,1) = MMM_Dynamics_Function( x, fs, 'Andorra' );
Key(12,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('dm.mp3');
Expression(13,1) = MMM_Dynamics_Function( x, fs, 'Dominica' );
Key(13,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('gd.mp3');
Expression(14,1) = MMM_Dynamics_Function( x, fs, 'Grenada' );
Key(14,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('ki.mp3');
Expression(15,1) = MMM_Dynamics_Function( x, fs, 'Kiribati' );
Key(15,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('li.mp3');
Expression(16,1) = MMM_Dynamics_Function( x, fs, 'Liechtenstein' );
Key(16,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('ca.mp3');
country = 'Canada';
Expression(17,1) = MMM_Dynamics_Function( x, fs, country );
Key(17,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('va.mp3');
Expression(18,1) = MMM_Dynamics_Function( x, fs, 'Vatican City' );
Key(18,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('ht.mp3');
Expression(19,1) = MMM_Dynamics_Function( x, fs, 'Haiti' );
Key(19,1) = MMM_Key_Function( x, fs );

[x, fs] = audioread('pw.mp3');
Expression(20,1) = MMM_Dynamics_Function( x, fs, 'Palau' );
Key(20,1) = MMM_Key_Function( x, fs );

%Ambiguous
[x, fs] = audioread('kp.mp3');
Expression(21,1) = MMM_Dynamics_Function( x, fs, 'North Korea' );
%Key(21,1) = MMM_Key_Function( x, fs );
Key(21,1) = {'major'};

%Table of Scores for Dynamics

row_names = {'USA','Russia','China','Japan','India','France','South Korea',...
    'Italy','UK','Turkey','Costa Rica','Andorra','Dominica','Grenada','Kiribati',...
    'Liechtenstein','Canada','Vatican City','Haiti','Palau','North Korea'};

lowThird  = 0.5*max(Expression);
highThird = 0.75*max(Expression);

Dynamics = cell(21,1);

for k = 1:length(Expression)
    if Expression(k) < lowThird
        Dynamics(k,1) = {'Small'};
    elseif Expression(k) < highThird
        Dynamics(k,1) = {'Moderate'};
    else
        Dynamics(k,1) = {'Large'};
    end
    if Tempo(k) < 70
        Pace(k,1) = {'Slow'};
    elseif Tempo(k) < 100
        Pace(k,1) = {'Moderate'};
    else
        Pace(k,1) = {'Fast'};
    end
end

Emotions = cell(21,1);
Emotions = MMM_Emotions_Function(Key,Pace,Dynamics);

Scores  = table(Key,Tempo,Pace,Expression,Dynamics,Emotions,'RowNames',row_names);

figure(22)
row_names(2:22) = row_names(1:21);
row_names(1)    = {''};
dBchart = bar(Expression);
set(gca,'XTickLabel',row_names)
title('Expression By Country')

figure(23)
paceChart = bar(Tempo);
set(gca,'XTickLabel',row_names)
title('Pace By Country')

clc;
disp(Scores);