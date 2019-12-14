close all; clear; clc

image = imread( './Dubai_1.png' );
image = double( image )/255;

% figure( 'Name', 'Original' )
% imshow( image );
% title( 'Original' )

%% different color layers
copy = image;
red_layer = image(:,:,1);
green_layer = image(:,:,2);
blue_layer = image(:,:,3);

%% enhancement parameters
% red_layer = red_layer.^2;
% green_layer = green_layer.^2;
% blue_layer = blue_layer.^3;

% threshold = 0.5;
% red_layer( red_layer < threshold ) = 0;
% red_layer( red_layer >= threshold ) = (1/(1-threshold))*red_layer( red_layer >= threshold ) - threshold/(1-threshold);

% red_layer( red_layer < 0.4 | red_layer > 0.6 ) = 0;

%% some histograms
n = 100; % number of bins
figure( 'Name', 'Histograms' )
subplot(131)
histogram( red_layer, n )
title( 'Red' )
subplot(132)
histogram( green_layer, n )
title( 'Green' )
subplot(133)
histogram( blue_layer, n )
title( 'Blue' )

%% just blue
num_plots = 5;

figure( 'Name', 'Just blue' )
subplot(1, num_plots, 1)
imshow( image(:,:,3) )
title( 'Original' )

% segmentation?
max = 5;
for i = 1:max
    blue_layer( blue_layer >= (i-1)*1/max & blue_layer < i*1/max ) = (i-1)*1/max;
end
subplot(1, num_plots, 2)
imshow( blue_layer )
title( 'After Segmentation' )

% thresholding
blue_layer( blue_layer < .5 ) = 0;
subplot(1, num_plots, 3)
imshow( blue_layer )
title( 'After Thresholding' )

% fill holes
blue_layer = imfill( blue_layer );
subplot( 1, num_plots, 4 )
imshow( blue_layer )
title( 'After hole filling' )

% open and close
sebc = strel( 'disk', 0 );
sebo = strel( 'disk', 10 );
blue_layer = imclose( blue_layer, sebc );
blue_layer = imopen( blue_layer, sebo );
subplot( 1, num_plots, 5 )
imshow( blue_layer )
title( 'After Open and Close' )

blue_layer( blue_layer > 0 ) = 255;

%% just green
num_plots = 3;
figure( 'Name', 'Just Green' )
subplot( 1, num_plots, 1 )
imshow( image(:,:,2) )
title( 'Original' )

% segmentation?
% max = 10;
% for i = 1:max
%     green_layer( green_layer >= (i-1)*1/max & green_layer < i*1/max ) = (i-1)*1/max;
% end
% subplot(1, num_plots, 2)
% imshow( green_layer )
% title( 'After Segmentation' )

% thresholding
green_layer( green_layer < 0.5 | green_layer > 0.7 ) = 0;

subplot( 1, num_plots, 2 )
imshow( green_layer )
title( 'Thresholding' )

% hole filling does not help

% open and close parameters
sego = strel( 'disk', 10 ); % for opening
segc = strel('disk', 0 ); % for closing
green_layer = imopen( green_layer, sego );
green_layer = imclose( green_layer, sego );
subplot( 1, num_plots, 3 )
imshow( green_layer )
title( 'Open and close' )

green_layer( green_layer > 0 ) = 255;

%% edge width
sed = strel( 'disk', 3 );

%% just blue edges
edge_t = 0.05;
blue_edges = edge( blue_layer, 'Prewitt', edge_t );

% "dilate" edges to make them bigger
blue_edges = imdilate( blue_edges, sed );

num_plots = 2;
figure( 'Name', 'After edge detection (with blue layer)' )
subplot( 1, num_plots, 1 )
imshow( blue_edges )
title( 'Edges detected' )

% make edges appear blue in image
image(:,:,3) = image(:,:,3) + blue_edges;
image(:,:,2) = image(:,:,2) .* ( blue_edges == 0 );
image(:,:,1) = image(:,:,1) .* ( blue_edges == 0 );

subplot( 1, num_plots, 2 )
imshow( image )
title( 'Detected Buildings' )

%% just green edges
edge_t = 0.05;
green_edges = edge( green_layer, 'Prewitt', edge_t );

% "dilate" edges to make them bigger
green_edges = imdilate( green_edges, sed );

num_plots = 2;
figure( 'Name', 'After edge detection (with green layer)' )
subplot( 1, num_plots, 1 )
imshow( green_edges )
title( 'Edges detected' )

% make edges appear green in image
image(:,:,2) = image(:,:,2) + green_edges;
image(:,:,3) = image(:,:,3) .* ( green_edges == 0 );
image(:,:,1) = image(:,:,1) .* ( green_edges == 0 );

subplot( 1, num_plots, 2 )
imshow( image )
title( 'Detected Buildings' )

%% final result
figure( 'Name', 'All detected buildings' )
subplot(121)
imshow( copy )
title( 'Original' )
subplot(122)
imshow( image )
title( 'Detected Buildings' )

