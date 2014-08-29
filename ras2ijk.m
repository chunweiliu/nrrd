function ijk = ras2ijk(ras, meta)
%RAS2IJK Transfer a point from RAS system using meta in LPS

% parse meta data
C = textscan(meta.sizes,'%d');
s = double(C{1});
C = textscan(meta.spacedirections,'(%f,%f,%f)');
D = [C{1} C{2} C{3}];
C = textscan(meta.spaceorigin,'(%f,%f,%f)'); % original in LPS
d = [-(s(1)*D(1,1)+C{1}) -(s(2)*D(2,2)+C{2}) C{3}]'; % original in RAS

% transfrom ras 
tmp = D\(ras-d);
ijk = [s(1)-tmp(1) s(2)-tmp(2) tmp(3)]'; % flip the coordinates
%ijk = round(ijk); % round if need

end