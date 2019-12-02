close

threshold = 0.015;

image = imread( './harlem2.png' );

% need to blur images first; resolution is too good
blurred = imgaussfilt( image, 0.1 );

% add blurring, enhancement(?), increase contrast, filter for noise?, ...

gray_image = rgb2gray( blurred );
% gray_image = blurred;

edges = edge( gray_image, 'Prewitt', threshold );

figure
subplot(121)
imshow( image )
subplot(122)
imshow( edges )