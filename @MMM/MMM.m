% Class description here

classdef MMM < handle
    
    % Class properties. These can be public, since users may want to see
    % them in their workspace.
    properties (Access = public)
        
        % List of all the MP3 audio files.
        songList;
        
        % Evaluation output structure.
        evalOutput = struct('key', {},...
                            'tempo', {},...
                            'pace', {},...
                            'expression', {},...
                            'dynamics', {},...
                            'emotion', {}...
                           );
         
        % Table of results
        resultTable;
        
    end
    
    properties (Hidden = true)
        
        % The root directory of the class.
        %
        % This is useful for path setup and for locating MP3 files.
        rootDir;
        
        % Current song information
        currentSong = struct('name', '',...
                             'x', {},...
                             'fs', {}...
                            );
        
    end
    
    methods
        
        % Constructor
        function obj = MMM()
            obj.rootDir = fileparts(fileparts(mfilename('fullpath')));
            addpath(fullfile(obj.rootDir, 'MMM Library'));
            addpathRecursive(obj.rootDir);
            obj.songList = obj.getSongList();
        end
        
        function list = getSongList(obj)
            songDir = fullfile(obj.rootDir, 'MP3 Files');
            list = ls(songDir);
            list = strsplit(list);
            list = list(~cellfun('isempty', list));
            obj.songList = list;
        end
        
        function generateTable(obj)
            rowNames = obj.songList;
            Key = obj.evalOutput.key;
            Tempo = obj.evalOutput.tempo;
            Pace = obj.evalOutput.pace;
            Expression = obj.evalOutput.expression;
            Dynamics = obj.evalOutput.dynamics;
            Emotion = obj.evalOutput.emotion;
            obj.resultTable = table(Key,...
                                    Tempo,...
                                    Pace,...
                                    Expression,...
                                    Dynamics,...
                                    Emotion,...
                                    'RowNames', rowNames...
                                   );
            
        end
        
    end
    
end