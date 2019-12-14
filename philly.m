close all; clear; clc

image = imread( './philly.png' );
image = double( image )./255;
copy = image;

red_layer = image(:,:,1);
green_layer = image(:,:,2);
blue_layer = image(:,:,3);

%% color split
colorsplit( image, 'Philly colors' );

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

%% draw edges on image in red
draw_edges( image, edges, 1, 'Detected Buildings in Philly' );