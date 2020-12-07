clc
clear

% Read image
RGB = imread('./DB1/db1_11.jpg');
figure; 

figure, imshow(RGB);

% White balance
rgbImageWhite = whiteBalance(RGB);

% Face mask
mask = faceMask2(rgbImageWhite);

figure, imshow(mask)

% Eye map
eyeMap = eyeMap1(rgbImageWhite);

% Combine
eyeMap = eyeMap .* mask;

figure, imshow(eyeMap)

%%
% Eye map
% I = eyeMap(RGB, 15);
figure, imshow(RGB); title(['1']);
%RGB = grayWorld(RGB);
%figure, imshow(RGB); title(['1']);

RGB = whitePatch(RGB);
figure, imshow(RGB); title(['2']);

% Binary image
I = rgb2gray(RGB);
bw = imbinarize(I);

% Morphalogical operations
bw = bwareaopen(bw,30);

se = strel('disk',2);

bw = imclose(bw,se);
%figure, imshow(bw);
bw = imfill(bw,'holes');

figure, imshow(bw);
figure

% Find boudaries 
[B,L] = bwboundaries(bw,'noholes');

%imshow(label2rgb(L,@jet,[.5 .5 .5]))
% hold on

for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2),boundary(:,1),'w','LineWidth',2)
end

stats = regionprops(L,'Area','Centroid');

threshold = 0.94;

% loop over the boundaries
for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  
  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;
  
  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;
  
  % display the results
  metric_string = sprintf('%2.2f',metric);

  % mark objects above the threshold with a black circle
  if metric > threshold
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
  end
  
end

   
   
   
   %% 
   
   
FM = faceMask(RGB);
% figure, imshow(FM);

RGB = grayWorld(RGB);
RGB = whitePatch(RGB);
RGB = eyeMap(RGB, 12);

% figure, imshow(RGB);

RES = FM .* im2double(RGB);

% figure, imshow(RES);


