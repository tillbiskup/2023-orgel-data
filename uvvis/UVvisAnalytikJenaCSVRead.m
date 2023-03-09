function dataset = UVvisAnalytikJenaCSVRead(filename)
% UVVISANALYTIKJENACSVREAD Import CSV export of Analytik Jena Specord
%
% Usage:
%   data = UVvisAnalytikJenaCSVRead(filename)
%
%   filename - string
%              Name of the file to load (usually ending in .CSV)
%
%   data     - struct
%              imported data

% Copyright (c) 2020, Till Biskup
% 2020-06-29

delimiter = ';';
nHeaderLines = 2;

dataset = commonDatasetCreate();

importedData = importdata(filename, delimiter, nHeaderLines);
dataset.data = importedData.data(:,2);
dataset.origdata = dataset.data;

dataset.header = importedData.textdata;

dataset.file.name = filename;
dataset.file.format = 'AnalytikJena CSV Export';

dataset.axes.data(1).values = importedData.data(:,1);
dataset.axes.data(1).measure = 'wavelength';
dataset.axes.data(1).unit = 'nm';

% Set y axis depending on data file
if any(strfind(dataset.header{1},'[A]'))
    dataset.axes.data(2).measure = 'absorption';
    dataset.axes.data(2).unit = 'a.u.';
end

dataset.axes.origdata(1) = dataset.axes.data(1);
dataset.axes.origdata(2) = dataset.axes.data(2);

end
