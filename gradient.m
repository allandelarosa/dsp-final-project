close all; clear;

image = imread( './Dubai_1.png' );
% enhancement
temp_im = double( image )/255;
% f = 2*log( 1 + (temp_im) );
f = (temp_im).^2.0;
%f =10.^(temp_im);
figure
subplot(121)
imshow( image )
subplot(122)
imshow(f)

gray_image = rgb2gray( image );
figure
subplot(121)
imshow( image )
subplot(122)
imshow( gray_image )

image = double(image)/255;
image = (image).^2.0;
figure
imshow(image)
title('figure 3');


% display rgb layers individually
ave_red = mean(image(:,:,1));
ave_green = mean(image(:,:,2));
ave_blue = mean(image(:,:,3));

for i = 1:length(image(:, 1,1))
    for j=1:length(image(1, :, 1))
        if image(i, j, 1) < ave_red
            image(i, j, 1) = image(i, j, 1)/1.5;
        end 
        if image(i, j, 2) < ave_green
            image(i, j, 2) = image(i, j, 2)/1.5;
        end 
        if image(i, j, 3) < ave_blue
            image(i, j, 3) = image(i, j, 3)/1.5;
        end 
    end 
end 

figure
subplot(131)
imshow( image(:,:,1) )
subplot(132)
imshow( image(:,:,2) )
subplot(133)
imshow( image(:,:,3) )
se = strel('rectangle', [5,5]);
se1 = strel('disk', 4);
gray = rgb2gray(image);
figure;
subplot(131)
imshow(gray)
subplot(132)
imshow(imopen(gray, se))
subplot(133)
imshow(imclose(imopen(gray, se), se1))
after= imclose(imopen(gray, se), se1);
figure;
edges = edge( after, 'Prewitt', 0.07 );
subplot(121)
imshow( edges )
subplot(122)
imshow(image)
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
% 
% function Gx = my_gx( im ) 
%     [m,n] = size( im );
%     Gx = zeros( [m,n] );
%     
%     for i = 1:m
%         for j = 1:n
%             if i == m || j == 1; g1 = 0; else; g1 = im(i+1,j-1); end
%             if i == m          ; g2 = 0; else; g2 = im(i+1,j); end
%             if i == m || j == n; g3 = 0; else; g3 = im(i+1,j+1); end
%             
%             if i == 1 || j == 1; g4 = 0; else; g4 = im(i-1,j-1); end
%             if i == 1          ; g5 = 0; else; g5 = im(i-1,j); end
%             if i == 1 || j == n; g6 = 0; else; g6 = im(i-1,j+1); end
%             
%             Gx(i,j) = (g1 + g2 + g3) - (g4 + g5 + g6);
%         end
%     end
% end
% 
% function Gy = my_gy( im ) 
%     [m,n] = size( im );
%     Gy = zeros( [m,n] );
%     
%     for i = 1:m
%         for j = 1:n
%             if i == 1 || j == 1; g1 = 0; else; g1 = im(i-1,j-1); end
%             if           j == 1; g2 = 0; else; g2 = im(i,j-1); end
%             if i == m || j == 1; g3 = 0; else; g3 = im(i+1,j-1); end
%             
%             if i == 1 || j == n; g4 = 0; else; g4 = im(i-1,j+1); end
%             if           j == n; g5 = 0; else; g5 = im(i,j+1); end
%             if i == m || j == n; g6 = 0; else; g6 = im(i+1,j+1); end
%             
%             Gy(i,j) = (g1 + g2 + g3) - (g4 + g5 + g6);
%         end
%     end
% end
