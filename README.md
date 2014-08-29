NRRD
====

Tools for processing NRRD file in Matlab
* Input/Ouput
    - nrrdread (by The MathWorks, Inc.)
    - nrrdwrite
* Coordinates
    - ras2ijk
    - ijk2ras

# I/O Usage
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

# Coordinate transform
```matlab
% read nrrd meta
[~, meta] = nrrdread('your_nrrd_file.nrrd');

% assuming a point ras in RAS coordinates is known, transfer it to matlab coordinates
ijk = ras2ijk(ras, meta);

% transform it back to ras
ras = ijk2ras(ijk, meta);
```