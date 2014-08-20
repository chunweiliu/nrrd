function nrrdwrite(filename,X,meta)
% Write data in nrrd format
% Arguments
% - filename: output file name
% - X: array data to be written
% - meta: struct from nrrdread

% Open file
fid = fopen(filename, 'wb');
assert(fid > 0, 'Could not open file.');

% Write header
fprintf(fid, 'NRRD0001\n');

formatspec = '%s: %s\n';
fn = fieldnames(meta);
for i = 1:length(fn)
    field = fn{i};
    value = meta.(fn{i});
    
    % Since fwrite didn't encoding, write in raw format
    if strcmp(field,'encoding')
        value = 'raw';
    end
    fprintf(fid, formatspec, field, value);
end
fprintf(fid,'\n');

% Write binary data in raw format
dims = sscanf(meta.sizes, '%d');
ndims = sscanf(meta.dimension, '%d');
assert(numel(dims) == ndims);

X = reshape(X, dims');
X = permute(X, [2 1 3]);

fwrite(fid,X,meta.type);

% Close file
cleaner = onCleanup(@() fclose(fid));

end