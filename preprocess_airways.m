function preprocess_airways(input_folder, output_folder)
%PREPROCESS_AIRWAYS Apply follows preprocessing to all nrrd files in folder
% 1. Padding
% 2. Filterring
% args
% - input_folder: string, a folder contained multiple nrrd files
% - output_folder: string, a folder contained multiple preprocessed nrrd

PADDING = 40;
AIR_VAL = -1024;

FILE_EXT = '*.nrrd';
files = dir(fullfile(input_folder,FILE_EXT));

if length(files) > 1 && ~exist(output_folder,'dir')
    mkdir(output_folder)
end

for i = 1:length(files)
    subject = files(i).name;
    fprintf('process %s\n',fullfile(input_folder,subject));
    
    [im,meta] = nrrdread(fullfile(input_folder,subject));
    
    % preprocessing
    [im,meta] = pad_airway(im,meta,PADDING,AIR_VAL);    
    [im,meta] = filter_airway(im,meta);
    
    nrrdwrite(fullfile(output_folder,subject),im,meta);
end

end

function [im, meta] = pad_airway(im,meta,padding,value)
meta.sizes = sprintf('%d %d %d',size(im,1),size(im,2),size(im,3)+padding);
im = cat(3,im,value*ones(size(im,1),size(im,2),padding));
end

function [im, meta] = filter_airway(im,meta)
%FILTER_AIRWAY Filter -2048 (background) to -1024 (air)
BACKGROUND_VAL = -2047;
AIR_VAL = -1024;
im(im<BACKGROUND_VAL) = AIR_VAL;
end



