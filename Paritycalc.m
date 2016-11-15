A = imread('leftimage_0015.jpg');
B = imread('rightimage_0015.jpg');
uniqLevels = unique(A(:));
Nvals = [14 16 18 20];
for i = 1:length(Nvals)
    [thresh, metric] = multithresh(A, Nvals(i) );
    disp(['N = ' int2str(Nvals(i)) '  |  metric = ' num2str(metric)]);
end
% threshRGB = multithresh(A,7);
% threshForPlanes = zeros(3,7);
% 
% for i = 1:3
%     threshForPlanes(i,:) = multithresh(A(:,:,i),7);
% end
% 
% value = [0 threshRGB(2:end) 255];
% quantRGB = imquantize(A, threshRGB, value);
% 
% quantPlane = zeros( size(A) );
% 
% for i = 1:3
%     value = [0 threshForPlanes(i,2:end) 255];
%     quantPlane(:,:,i) = imquantize(A(:,:,i),threshForPlanes(i,:),value);
% end
% 
% quantPlane = uint8(quantPlane);
% 
% figure;
% imshowpair(quantRGB,quantPlane,'montage')
% axis off
% title('Full RGB Image Quantization        Plane-by-Plane Quantization')




A = rgb2gray(A);
B = rgb2gray(B);
% I1 = im2single(A);
% I2 = im2single(B);
I1 = A;
I2 = B;
corners1 = detectHarrisFeatures(I1);
corners2 = detectHarrisFeatures(I2);
figure;
imshow(I1); hold on;
plot(corners1); hold off;
figure;
imshow(I2); hold on;
plot(corners2);

[n,m]=size(A);
%I1 = imgaussfilt(A);
%I2 = imgaussfilt(B);
stereo = stereoAnaglyph(I1,I2);
disparityRange = [42 58];
disparityMap = disparity(I1,I2,'DisparityRange',disparityRange);
% figure
% imshow(disparityMap,disparityRange);
% title('Disparity Map');
% colormap jet
% colorbar

% xyzPoints = reconstructScene(disparityMap,stereoParams1);
% Z = xyzPoints(:,:,3);
% mask = repmat(Z > 3200 & Z < 3700,[1,1,3]);
% J1(~mask) = 0;
% imshow(J1,'InitialMagnification',50);