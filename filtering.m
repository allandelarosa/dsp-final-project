close all; clear; clc

image = imread( './Dubai_4.png' );
image = double( image )/255;

% figure( 'Name', 'Original' )
% imshow( image );
% title( 'Original' )

%% different color layers
red_layer = image(:,:,1);
green_layer = image(:,:,2);
blue_layer = image(:,:,3);

%% enhancement
% find average pizel value in gray layer
% gray = rgb2gray( image );
% avg = mean( gray, 'all' );
% 
% gray( gray > avg ) = max( gray, [], 'all' );
% gray( gray <= avg ) = max( gray, [], 'all' )/(avg+0.01)*gray( gray <= avg );
% 
% figure
% subplot(121)
% imshow( image )
% title( 'Original' )
% subplot(122)
% imshow( gray )
% title( 'Gray Scale Enhancement' )
% enhancement did not help

%% some histograms
colorsplit( image, 'Dubai Colors' );

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
title( 'After Hole Filling' )

% open and close
% sebc = strel( 'disk', 0 );
sebo = strel( 'disk', 10 );
% blue_layer = imclose( blue_layer, sebc );
blue_layer = imopen( blue_layer, sebo );
subplot( 1, num_plots, 5 )
imshow( blue_layer )
title( 'After Opening' )

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
title( 'After Thresholding' )

% hole filling does not help

% open and close parameters
sego = strel( 'disk', 10 ); % for opening
% segc = strel('disk', 0 ); % for closing
green_layer = imopen( green_layer, sego );
% green_layer = imclose( green_layer, sego );
subplot( 1, num_plots, 3 )
imshow( green_layer )
title( 'After Opening' )

green_layer( green_layer > 0 ) = 255;

%% edge width
sed = strel( 'disk', 3 );

%% just blue edges
edge_t = 0.05;
blue_edges = edge( blue_layer, 'Prewitt', edge_t );

% "dilate" edges to make them bigger
blue_edges = imdilate( blue_edges, sed );


%% just green edges
edge_t = 0.05;
green_edges = edge( green_layer, 'Prewitt', edge_t );

% "dilate" edges to make them bigger
green_edges = imdilate( green_edges, sed );


%% final result
draw_edges( image, cat(3,blue_edges,green_edges), [3 2], ...
    'Dubai Detected Buildings' );

