% Clear workspace and command window
clc;
clear all;
close all;

% Check if 'datalog-111.txt' exists and rename it to 'datalog-111.csv'
txtFileName = 'datalog-111.txt';
csvFileName = 'datalog-111.csv';

if isfile(txtFileName)
    movefile(txtFileName, csvFileName);
    disp(['Renamed ', txtFileName, ' to ', csvFileName]);
else
    disp([txtFileName, ' does not exist.']);
end

% Pattern Recognition Using Lookup Table
LOOKUPTABLE = [
    311113113 ;  % A
    113113113 ;  % B
    313113111 ;  % C
    111133113 ;  % D
    311133111 ;  % E
    113133111 ;  % F
    111113313 ;  % G
    311113311 ;  % H
    113113311 ;  % I
    111133311 ;  % J
    311111133 ;  % K
    113111133 ;  % L
    313111131 ;  % M
    111131133 ;  % N
    311131131 ;  % O
    113131131 ;  % P
    111111333 ;  % Q
    311111331 ;  % R
    113111331 ;  % S
    111131331 ;  % T
    331111113 ;  % U
    133111113 ;  % V
    333111111 ;  % W
    131131113 ;  % X
    331131111 ;  % Y
    133131111 ;  % Z
];

csvFileName = 'datalog-111.csv';
data = readmatrix(csvFileName);

encoderValues = data(:, 1);       % First column (Encoder values)
lightSensorValues = data(:, 2);   % Second column (Light sensor values)

% Plotting the whites and the blacks
plot(encoderValues, lightSensorValues, 'o-');
xlabel('Encoder Values');
ylabel('Light Sensor Values');
title('Light Sensor Values vs Encoder Values');
grid on;

% Calculate DataAveDif and plot
DataAveDif = abs(diff(lightSensorValues));
figure;
plot(DataAveDif);
hold on;

% Find peaks in DataAveDif
[pks,locs] = findpeaks(DataAveDif,'MinPeakHeight',5,'MinPeakDistance',5);
plot(locs,pks,'or');

widths = (locs(2:end)-locs(1:end-1));
widths = floor(widths/min(widths));

% Calculate dynamic thresholds based on percentiles or other criteria
lowThreshold = prctile(widths, 33);  % 33rd percentile
highThreshold = prctile(widths, 67); % 67th percentile

% Initialize the scaledWidths array with the same size as widths
scaledWidths = zeros(size(widths));

% Assign values based on thresholds
scaledWidths(widths < lowThreshold) = 1;
scaledWidths(widths > highThreshold) = 3;

% Fill in values between lowThreshold and highThreshold with 1 or 3
scaledWidths(widths >= lowThreshold & widths <= highThreshold) = 1; % or 3, depending on your criteria

CODE = str2num(strrep(reshape(num2str(scaledWidths), 1, []), ' ', ''));

coor = find(LOOKUPTABLE == CODE);
Letter = char(64+coor);

if isempty(Letter)
    disp('FAILED TO READ ');
    disp(['File: ', csvFileName]);
end

disp(['Widths: ', mat2str(widths)]);
disp(['Lookup Code: ', num2str(CODE)]);
disp(['Char: ', Letter]);