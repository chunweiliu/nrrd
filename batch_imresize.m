function batch_imresize(input_folder,output_folder,scale)
d = dir(fullfile(input_folder,'*.nrrd'));

% make the output folder if need
if length(d) > 1 && ~exist(output_folder,'dir')
    mkdir(output_folder)
end

for i = 1:length(d)
    filename = fullfile(input_folder,d(i).name);
    
    fprintf(1,'... process %s\n', filename);
    
    [im,meta] = nrrdread(filename);
    
    % resize and rewrite meta
    out = imresize3(im,scale);
    meta.sizes = sprintf('%d %d %d',size(out,1),size(out,2),size(out,3));
    
    coords = strsplit(meta.spacedirections);
    x = strsplit(coords{1},',');
    x = str2double(x{1}(2:end));
    y = strsplit(coords{2},',');
    y = str2double(y{2});
    z = strsplit(coords{3},',');
    z = str2double(z{3}(1:end-1));
    
    meta.spacedirections = sprintf('(%.3f,0,0) (0,%.3f,0) (0,0,%.3f)',...
        scale*x,scale*y,scale*z);
    
    nrrdwrite(fullfile(output_folder,d(i).name),out,meta);
end