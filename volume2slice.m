function volume2slice(input_folder, output_folder)
% Get a particular slice for each frame in a dynamic sequence
d = dir(fullfile(input_folder,'*.nrrd'));

if ~isempty(d) && ~exist(output_folder,'dir')
    mkdir(output_folder)
end

for i = 1:length(d)
    filename = fullfile(input_folder,d(i).name);
    fprintf(1,'... process %s\n', filename);
    
    im = nrrdread(filename);
    
    % rectify image
    slice = squeeze(im(:,size(im,2)/2,:));  % remove singluar axis
    slice = mat2gray(imresize(imrotate(slice,90),[512 512]));  % rescale
    slice = slice.^.7;  % addjust brightnest
    
    outname = fullfile(output_folder,[d(i).name(1:end-5),'.png']);
    imwrite(slice,outname);
end
