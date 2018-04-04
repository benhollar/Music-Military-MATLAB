function addpathRecursive(folder, root)
% As the name suggests, adds folders (and their subfolders) to the MATLAB
% path recursively. 
%
% Inputs:
%   folder: folder to add
%   root: typically, the folder above the folder, which should already be on
%       the MATLAB path.

if ~exist('root', 'var')
    root = folder;
end

foldersToAdd = dir(folder);
isDir = [foldersToAdd.isdir];
foldersToAdd = foldersToAdd(isDir);

for idx = 1:length(foldersToAdd)
    if strcmp(foldersToAdd(idx).name, '.')
        continue;
    end
    if strcmp(foldersToAdd(idx).name, '..')
        continue;
    end
    if strfind(foldersToAdd(idx).name, '@')
        addpath(root);
        continue;
    end
    addpathRecursive(foldersToAdd(idx).name, foldersToAdd(idx).name);
    addpath(fullfile(root, foldersToAdd(idx).name));
end

end