%--------------------------------------------------------------------------
% Created: 09/15/2016 by Robert Schurz, Bhargavi
% 
% Revision History: None
% 
% Purpose: This script reads in images and converts them to grayscale.
%
%--------------------------------------------------------------------------

% A = imread('Iphone5 - pole - 1.jpg');
% A1 = rgb2gray(A);

A = imrotate(imread('Iphone5 - stairs - 3.jpg'),-90);
A1 = rgb2gray(A);
A1 = wiener2(A1,[10 10]);
%A1 = imcomplement(A1);
%A1 = A1/max(max(A1));
% BW1 = edge(A1,'sobel');
% BW2 = edge(A1,'canny');
% figure;
% imshowpair(BW1,BW2,'montage')
% title('Sobel Filter                                   Canny Filter');
% [Gmag, Gdir] = imgradient(A1,'prewitt');

BW2 = edge(A1,'canny');
% R = 10;
% N = 4;
% SE = strel('disk',R,N);
% SE2 = strel('rectangle',[4 2]);
% SE3 = strel('diamond',R);
% Edgelinked1 = imdilate(BW2,SE);
% Edgelinked3 = imdilate(BW2,SE3);

SE2 = strel('rectangle',[4 2]);
Edgelinked2 = imdilate(BW2,SE2);
% CC = bwconncomp(Edgelinked1);
% L = bwlabel(Edgelinked1,4);