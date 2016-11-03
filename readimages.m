%--------------------------------------------------------------------------
% Created: 09/15/2016 by Robert Schurz, Bhargavi
% 
% Revision History: 09/22/2016 RS
% 
% Purpose: This script reads in images and converts them to grayscale.
%
%--------------------------------------------------------------------------

%A = imread('Iphone5 - pole - 1.JPG');
% A1 = rgb2gray(A);
tic
%A = imread('20161006_151623Hallway.jpg');
%A = imread('Door2.jpg');
%A = imread('DisparityDoor1.jpg');
%A = imread('DisparityDoor2.jpg');
%A = imread('20161006_hallway1.jpg');
%A = imread('20161006_151530Hallway.jpg');
%A = imread('20161006_151604Hallway.jpg');
A = imread('20161006_151750Hallway.jpg');
%hsv_image = rgb2hsv(A);
A1 = rgb2gray(A);
[n,m]=size(A1);
A1 = wiener2(A1,[10 10]);
%A1 = padarray(A1,[2,2],1,'both');
%A1 = medfilt2(A1, [3 3]);
%A1 = imgaussfilt(A1);
BW2 = edge(A1,'canny',(graythresh(A1) * 0.1));
%BW2 = edge(A1,'canny');
%BW2 = padarray(BW2,[2,2],1,'both');

se1 = strel('line',4,180);            % linear horizontal structuring element 
se2 = strel('line',4,90);             % linear vertical structuring element 
%I = rgb2gray(imread('20161006_151530Hallway.jpg'))>80;  % threshold (since i had a grayscale version of the image)
Idil = imdilate(imdilate(BW2,se1),se2); % dilate contours so that they connect
%Idil_area = bwareaopen(Idil,2000);    % area filter them to remove the small components

R = 3;
N = 4;
SE = strel('disk',R,N);
Edgelinked1 = imerode(Idil,SE);
Edgelinked1 = imclose(Idil,SE);
Idil_area1 = bwareaopen(Edgelinked1,50);

%Edgelinked1 = padarray(Edgelinked1,[1,1],0,'both');
%[B,L] = bwboundaries(Idil_area1);
Test = imfill(Idil_area1,'holes');
Test2 = imdilate(imerode(Test, SE),SE);
A1(~Test2)=0;
toc
%bw = bwareaopen(Edgelinked1,100);
%stat = regionprops(BW2,'Area','Centroid');
% figure;
% imshow(label2rgb(L, @jet, [.5 .5 .5]))
%          hold on
%          for k = 1:length(B)
%              boundary = B{k};
%              plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
%          end
% toc
% Edgelinked2 = imclose(BW2,SE);
%BW2 = bwareaopen(Edgelinked1,10);
%L = bwlabel(bw);
%Edgelinked2 = imdilate(Edgelinked1,SE);
% cc = bwconncomp(Edgelinked1);

%BW_filled = imfill(Edgelinked1,round(stats(20).Centroid));
%bw = bwlabel(Edgelinked1);
%[b,L] = bwboundaries(Edgelinked1,4);
%new = imerode(L,SE);
% for i=1:max(max(L))
%     image = ismember(L,i);
% end
% Test = regionprops(CC,'PixelList');
%toc
%[H,theta,rho] = hough(BW2);
%lines = houghlines(BW2,theta,rho,P,'FillGap',5,'MinLength',7);

% smooth = ones(5,5)/25;
% smooth2 = [1,2,1;2,4,2;1,2,1]/16;
% A1 = conv2(A1,smooth2);
% h1 = [-1,-2,-1;0,0,0;1,2,1]; %Sobel in x direction
% h2 = [-1,0,1;-1,0,1;-1,0,1]; %Sobel in y direction
% gx = conv2(A1,h1);
% gy = conv2(A1,h2);
% mxy = sqrt(gx.^2+gy.^2); %gradient image
% alpha = atand(gy./gx);
% gn = mxy;
% %use nonmaxima suppression to eliminate wide ridges around local maxima
% for i=2:n-1
%     for j=2:m-1
%         angle = alpha(i,j);
%         %horizontal edge
%         if abs(angle)<22.5 && abs(angle)>157.5
%         check1 = mxy(i,j)-mxy(i+1,j);
%         check2 = mxy(i,j)-mxy(i-1,j);
%         if check1<0 || check2<0
%             gn(i,j)=0;
%         end
%         %-45 degree edge
%         elseif (angle<67.5 && angle>22.5) || (angle<-112.5 && angle>-157.5)
%         check1 = mxy(i,j)-mxy(i+1,j-1);
%         check2 = mxy(i,j)-mxy(i-1,j+1);
%         if check1<0 || check2<0
%             gn(i,j)=0;
%         end
%         %vertical edge
%         elseif abs(angle)<112.5 && abs(angle)>67.5
%         check1 = mxy(i,j)-mxy(i,j+1);
%         check2 = mxy(i,j)-mxy(i,j-1);
%         if check1<0 || check2<0
%             gn(i,j)=0;
%         end
%         %+45 degree edge
%         else
%         check1 = mxy(i,j)-mxy(i+1,j+1);
%         check2 = mxy(i,j)-mxy(i-1,j-1);
%         if check1<0 || check2<0
%             gn(i,j)=0;
%         end    
%         end
%     end
% end
% %threshold gn to reduce false edge points
% TL = 0.005;
% TH = 0.015;
% gnh = (gn >= TH);
% gnl = (gn >=TL);
% toc

% level = graythresh(A1);
% img = im2bw(A1, level);
%A1 = imcomplement(A1);
%A1 = A1/max(max(A1));
% BW1 = edge(A1,'sobel');
% figure;
% imshowpair(BW1,BW2,'montage')
% title('Sobel Filter                                   Canny Filter');
% [Gmag, Gdir] = imgradient(A1,'prewitt');

% BW2 = edge(A1,'canny');
% R = 4;
% N = 4;
% SE = strel('disk',R,N);
% SE2 = strel('rectangle',[4 2]);
% SE3 = strel('diamond',R);
% Edgelinked1 = imdilate(BW2,SE);
% Edgelinked3 = imdilate(BW2,SE3);

% SE2 = strel('rectangle',[4 2]);
% Edgelinked2 = imdilate(BW2,SE2);
% [B,L,N] = bwboundaries(Edgelinked2);
% CC = bwconncomp(Edgelinked2);
% [t, n] = ind2sub([M,N],CC.PixelIdxList{1,170});
% test = imfill(Edgelinked2,[t,n]);
% stats = regionprops(Edgelinked2,'PixelIdxList','Area');
% idx = find([stats.Area] > 100);
% [M, N] = size(BW2);
% NewImage = zeros(M,N);
% for i=1:length(CC.PixelIdxList)
%     test1 = CC.PixelIdxList{1,i};
%     NewImage(test1)=1;
% end
% L = bwlabel(Edgelinked2,4);
% toc
