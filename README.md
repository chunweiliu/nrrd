nrrd
====

Input/Output for NRRD file format in Matlab

# Usage
```matlab
% read nrrd image in matlab
[data, meta] = nrrdread('your_nrrd_file.nrrd');

% process the data
processed_data = your_processing_function(data);

% edit meta data if necessary
processed_meta = your_editing_function(meta);

% write the processed data in nrrd
nrrdwrite('processed_file.nrrd', processed_data, processed_meta)
```