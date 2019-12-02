close all; clear;

image = imread( './harlem2.png' );
gray_image = rgb2gray( image );

% imresize used to make the resolution worse, since detection is too sensitive
% maybe blur is better?
% scale = 0.25;
% gray_image = imresize( gray_image, scale );
% gray_image = imresize( gray_image, 1/scale );
gray_image = imgaussfilt( gray_image, 3 );

% gradient using implementation in paper (it's not that good)
% my_gx and my_gy defined at the bottom
Gx = my_gx( gray_image );
Gy = my_gy( gray_image );
G = sqrt( Gx.^2 + Gy.^2 );
theta = atan( Gy./Gx );

% figure
% imshow( Gx + Gy )

% gradient using built-in functions
[gx,gy] = imgradientxy( gray_image, 'prewitt' );
[gmag,gdir] = imgradient( gx, gy );

figure
imshow( gx + gy )

% gradient by convolution 
% operators from wikipedia page on Prewitt operator
cx=[-1 -1 -1;0 0 0;1 1 1];
cy=[-1 0 1;-1 0 1;-1 0 1];
px=conv2(cx,gray_image);
py=conv2(gray_image,cy);

% figure
% imshow( px + py );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function definitions

function Gx = my_gx( im ) 
    [m,n] = size( im );
    Gx = zeros( [m,n] );
    
    for i = 1:m
        for j = 1:n
            if i == m || j == 1; g1 = 0; else; g1 = im(i+1,j-1); end
            if i == m          ; g2 = 0; else; g2 = im(i+1,j); end
            if i == m || j == n; g3 = 0; else; g3 = im(i+1,j+1); end
            
            if i == 1 || j == 1; g4 = 0; else; g4 = im(i-1,j-1); end
            if i == 1          ; g5 = 0; else; g5 = im(i-1,j); end
            if i == 1 || j == n; g6 = 0; else; g6 = im(i-1,j+1); end
            
            Gx(i,j) = (g1 + g2 + g3) - (g4 + g5 + g6);
        end
    end
end

function Gy = my_gy( im ) 
    [m,n] = size( im );
    Gy = zeros( [m,n] );
    
    for i = 1:m
        for j = 1:n
            if i == 1 || j == 1; g1 = 0; else; g1 = im(i-1,j-1); end
            if           j == 1; g2 = 0; else; g2 = im(i,j-1); end
            if i == m || j == 1; g3 = 0; else; g3 = im(i+1,j-1); end
            
            if i == 1 || j == n; g4 = 0; else; g4 = im(i-1,j+1); end
            if           j == n; g5 = 0; else; g5 = im(i,j+1); end
            if i == m || j == n; g6 = 0; else; g6 = im(i+1,j+1); end
            
            Gy(i,j) = (g1 + g2 + g3) - (g4 + g5 + g6);
        end
    end
end
