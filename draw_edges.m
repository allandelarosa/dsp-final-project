% draws edges on original image in specified color
% third arg is color of edges
% fourth arg is figure name

% if edges of different colors are desired, can also input
% edges as a MxNxj matrix with a 1xj matric to indicate colors

function draw_edges = draw_edges( image, edges, c, fig_name )

figure( 'Name', fig_name )
subplot(121)
imshow( image )
title( 'Original' )

for i = 1:3
    for j = 1: length(c)
    layer = image(:,:,i);
        if i == c(j)
            layer( edges(:,:,j) > 0 ) = 1;
        else
            layer( edges(:,:,j) > 0 ) = 0;
        end
        image(:,:,i) = layer;
    end
end

subplot(122)
imshow( image )
title( 'Detected Buildings' )

end