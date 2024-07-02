% Clear workspace and command window
clc;
clear all;
close all;

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

for letterIndex = 1:26
    filename = [char(64 + letterIndex), '.jpg'];

    % Load the image
    MyRawImage = imread(filename);
    
    % Convert to grayscale if image is in RGB format
    if size(MyRawImage, 3) == 3
        MyRawImage = rgb2gray(MyRawImage);
    end
    
    % Check the size of MyRawImage
    [imageHeight, imageWidth] = size(MyRawImage);
    
    % Display the dimensions of the image
    disp(['Image dimensions: ', num2str(imageHeight), ' x ', num2str(imageWidth)]);
    
    % Choose a valid row index within the image dimensions
    rowIndex = 400;
    
    % Check if the rowIndex is within bounds
    if rowIndex <= imageHeight
        % Access the selected row and convert to double
        OneLineData = double(MyRawImage(rowIndex, :));
    
        % Plot the extracted data
        plot(OneLineData);
        
        % Proceed with your further processing...
        % Example: Moving Average Filter with window size of ws
        ws = 10;
        OneLineDataAve = movmean(OneLineData, ws);
        hold on;
        plot(OneLineDataAve);
        
        % Calculate DataAveDif and plot
        DataAveDif = abs(diff(OneLineDataAve));
        plot(DataAveDif);
        hold on;
    
        % Find peaks in DataAveDif
        [pks,locs] = findpeaks(DataAveDif,'MinPeakHeight',19,'MinPeakDistance',15);
        plot(locs,pks,'or');
    
        widths = (locs(2:end)-locs(1:end-1));
        %%
        widths = floor(widths/min(widths));
                   
        CODE = str2num(strrep(num2str(widths), ' ', ''));
    
        % Find matching code in lookup table
        coor = find(LOOKUPTABLE == CODE);
        Letter = char(64+coor);
        
        disp(['Lookup Code: ', num2str(CODE)]);
        disp(['Char: ', Letter]);
    else
        % Handle the case where rowIndex exceeds the number of rows in the image
        error(['Row index ', num2str(rowIndex), ' exceeds the number of rows in the image.']);
    end
end