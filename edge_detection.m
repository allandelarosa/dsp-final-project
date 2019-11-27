close

threshold = 0.01;

image = imread( './Damascus_2011.png' );

% need to blur images first; resolution is too good
blurred = imgaussfilt( image, 8 );

gray_image = rgb2gray( blurred );

edges = edge( gray_image, 'Prewitt', threshold );

figure
subplot(121)
imshow( image )
subplot(122)
imshow( edges )