function [lat,lon,pow] = plotGeoData(file,path)
T = readtable([path,file]);
lonCell = regexp(T.Longitude,'\d*','match');
latCell = regexp(T.Latitude,'\d*','match');
lon = cellfun(@(x) dms2degrees([str2double(x{1}),str2double(x{2}),str2double(x{3})]),lonCell);
lat = cellfun(@(x) dms2degrees([str2double(x{1}),str2double(x{2}),str2double(x{3})]),latCell);
pow = T.Power;
end