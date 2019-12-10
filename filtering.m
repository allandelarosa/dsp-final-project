close all; clear; clc

image = imread( './Dubai_1.png' );
image = double( image )/255;

% figure( 'Name', 'Original' )
% imshow( image );
% title( 'Original' )

%% different color layers
red_layer = image(:,:,1);
green_layer = image(:,:,2);
blue_layer = image(:,:,3);

%% enhancement parameters
red_layer = red_layer.^2;
green_layer = green_layer.^2;
% blue_layer = blue_layer.^3;

% threshold = 0.5;
% red_layer( red_layer < threshold ) = 0;
% red_layer( red_layer >= threshold ) = (1/(1-threshold))*red_layer( red_layer >= threshold ) - threshold/(1-threshold);

% red_layer( red_layer < 0.5 | red_layer > 0.7 ) = 0;

%% just blue
num_plots = 4;

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

% open and close
sebc = strel( 'disk', 3 );
sebo = strel( 'disk', 15 );
blue_layer = imclose( blue_layer, sebc );
blue_layer = imopen( blue_layer, sebo );
subplot( 1, num_plots, 4 )
imshow( blue_layer )
title( 'After Open and Close' )

blue_layer( blue_layer > 0 ) = 255;

%% just blue edges
num_plots = 2;
figure( 'Name', 'Just blue edges' )
subplot( 1, num_plots, 1 )
imshow( image )
title( 'Original' )

% edge detection
edge_t = 0.;
blue_edges = edge( blue_layer, 'Prewitt', edge_t );
subplot( 1, num_plots, 2 )
imshow( blue_edges )
title( 'After edge detection' )

% close edges?
% sebo = strel( 'disk', 10 );
% blue_edges = imclose( blue_edges, sebo );
% subplot( 1, num_plots, 3 )
% imshow( blue_edges )
% title( 'After closing' )

%% open and close parameters
% not sure if we need to close
% set radius to 0 for no effect
seo = strel( 'disk', 0 ); % for opening
sec = strel('disk', 0 ); % for closing

%% applying processing
for i = 1:1
    % open and close
%     red_layer = imopen( red_layer, seo );
    red_layer = imclose( red_layer, sec );
    red_layer = imopen( red_layer, seo );
%     green_layer = imclose( imopen( green_layer, seo ), sec );
%     blue_layer = imclose( imopen( blue_layer, seo ), sec );
end

%% show effects of processing on each layer
dummy = zeros( size( image(:,:,1) ) );
red_image = cat( 3, red_layer, dummy, dummy );
green_image = cat( 3, dummy, green_layer, dummy );
blue_image = cat( 3, dummy, dummy, blue_layer );

% figure( 'Name', 'Effect of Processing' )
% subplot(121)
% imshow( image(:,:,1) )
% title( 'Original' )
% subplot(122)
% imshow( red_layer )
% title( 'Enhanced' )

figure( 'Name', 'Color Split' )
subplot(141)
imshow( image )
title( 'Original' )
subplot(142)
imshow( red_image )
title( 'Red' )
subplot(143)
imshow( green_image )
title( 'Green' )
subplot(144)
imshow( blue_image )
title( 'Blue' )

