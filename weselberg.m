close all; clear; clc

image = imread( './weselberg.png' );
image = double( image )./255;
copy = image;

red_layer = image(:,:,1);
green_layer = image(:,:,2);
blue_layer = image(:,:,3);

%% color split
colorsplit( image, 'Weselberg Colors' );

%% playing around with colors
%% just blue; used for getting rid of road
figure( 'Name', 'Blue' )
subplot(141)
imshow( blue_layer )

blue_layer( blue_layer < 0.42 | blue_layer > 0.5 ) = 0;
subplot(142)
imshow( blue_layer )

blue_layer = imfill( blue_layer );
subplot(143)
imshow( blue_layer )

se = strel( 'disk', 3 );
blue_layer = imopen( blue_layer, se );
subplot(144)
imshow( blue_layer )

%% just red; bright part of houses
figure( 'Name', 'Red' )
subplot(141)
red_layer( red_layer < 0.5 ) = 0;
imshow( red_layer )
title( 'Thresholding' )

red_layer( blue_layer > 0 ) = 0;
subplot(142)
imshow( red_layer )
title( 'Road Removed' )

red_layer = imfill( red_layer );
subplot(143)
imshow( red_layer )
title( 'Filling' )

se = strel( 'disk', 2 );
red_layer = imopen( red_layer, se );
subplot(144)
imshow( red_layer )
title( 'Opening' )

%% just green; dark part of houses
figure( 'Name', 'Green' )
green_layer( green_layer > 0.3 )= 0;
subplot(141)
imshow( green_layer )
title( 'Thresholding' )

green_layer( blue_layer > 0 ) = 0;
subplot(142)
imshow( green_layer )
title( 'Road Removed' )

green_layer = imfill( green_layer );
subplot(143)
imshow( green_layer )
title( 'Filling' )

se = strel( 'disk', 2 );
green_layer = imopen( green_layer, se );
subplot(144)
imshow( green_layer )
title( 'Opening' )

%% all together
buildings = red_layer + green_layer;
buildings( buildings > 0 ) = 255;
edge_t = 0.5;
edges = edge( buildings, 'Prewitt', edge_t );
sed = strel( 'disk', 2 );
edges = imdilate( edges, sed );

%% draw edges on image in red
draw_edges( image, edges, 1, 'Detected Buildings in Weselberg' );