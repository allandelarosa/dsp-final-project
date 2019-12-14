close all; clear; clc

image = imread( './philly.png' );
image = double( image )./255;
copy = image;

red_layer = image(:,:,1);
green_layer = image(:,:,2);
blue_layer = image(:,:,3);

dummy = zeros( size( red_layer ) );
red_image = cat( 3, red_layer, dummy, dummy );
green_image = cat( 3, dummy, green_layer, dummy );
blue_image = cat( 3, dummy, dummy, blue_layer );

%% color split
figure( 'Name', 'Color Split' )
% images
subplot(241)
imshow( image )
title( 'Original' )
subplot(242)
imshow( red_image )
title( 'Red' )
subplot(243)
imshow( green_image )
title( 'Green' )
subplot(244)
imshow( blue_image )
title( 'Blue' )
% histograms
n = 100;
subplot(246)
histogram( red_layer, n )
subplot(247)
histogram( green_layer, n )
subplot(248)
histogram( blue_layer, n )

%% remove trees and grass
num_plots = 4;
lawn_mask = rgb2gray( image );
figure( 'Name', 'temp name' )
subplot(1, num_plots, 1)
imshow(image)

% remove sections based on color information from histograms
lawn_mask( green_layer < 0.6 & red_layer < 0.5 & blue_layer < 0.5 ) = 0;
subplot(1, num_plots, 2)
imshow(lawn_mask)

% fill holes
lawn_mask = imfill( lawn_mask );
subplot(1, num_plots, 3)
imshow(lawn_mask)

% open and close
selo = strel( 'disk', 5 );
lawn_mask = imopen( lawn_mask, selo );
subplot(1,num_plots,4)
imshow( lawn_mask )

%% attempt to detect edges
lawn_mask( lawn_mask > 0 ) = 255;
edge_t = 0.5;
edges = edge( lawn_mask, 'Prewitt', edge_t );
sed = strel( 'disk', 2 );
edges = imdilate( edges, sed );

figure( 'Name', 'Edges' )
imshow( edges )

%% draw edges on imagei n red
red_layer( edges > 0 ) = 1;
green_layer( edges > 0 ) = 0;
blue_layer( edges > 0 ) = 0;

figure( 'Name', 'Detected Buildings' )
subplot(121)
imshow(image)
subplot(122)
imshow(cat(3,red_layer,green_layer,blue_layer))