% draws edges on original image in specified color
% third arg is color of edges
% fourth arg is figure name

function draw_edges = draw_edges( image, edges, c, fig_name )

figure( 'Name', fig_name )
subplot(121)
imshow( image )
title( 'Original' )

for i = 1:3
    layer = image(:,:,i);
    if i == c
        layer( edges > 0 ) = 1;
    else
        layer( edges > 0 ) = 0;
    end
    image(:,:,i) = layer;
end

subplot(122)
imshow( image )
title( 'Detected Buildings' )

end