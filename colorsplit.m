% shows intensity distribution on different color layers
% second arg is title for figure

function colorsplit = colorsplit( image, fig_name )

dummy = zeros( size( image(:,:,1) ) );

figure( 'Name', fig_name )
% images

subplot(231)
imshow( cat( 3, image(:,:,1), dummy, dummy ) )
title( 'Red' )
subplot(232)
imshow( cat( 3, dummy, image(:,:,2), dummy ) )
title( 'Green' )
subplot(233)
imshow( cat( 3, dummy, dummy, image(:,:,3) ) )
title( 'Blue' )

% histograms
n = 100;
subplot(234)
histogram( image(:,:,1), n )
title( 'Red Intensity Distribution' )
subplot(235)
histogram( image(:,:,2), n )
title( 'Green Intensity Distribution' )
subplot(236)
histogram( image(:,:,3), n )
title( 'Blue Intensity Distribution' )

end