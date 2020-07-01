clc
clear all;
close all;

global noPlate;
noPlate = [];
plates = [];

filename = 'C:\Users\Admin\Desktop\Number Plate Detection\Number Plate Images\video2.mp4';
v = VideoReader(filename);
image = read(v,1); 
imgray = rgb2gray(image);
imbin = imbinarize(imgray,0.62);
per = sum(imbin(:))/numel(imbin) * 100;
th = -0.8696662 + 0.1200641*per - 0.002260232*per*per;

num = get(v,'NumberOfFrames');
for k = 2:num
    image = read(v,k); 
    imgray = rgb2gray(image);
    imbin = imbinarize(imgray,0.62);
    per = sum(imbin(:))/numel(imbin) * 100;
    imbin = imbinarize(imgray, th);
    
    if per < 86
        [imbin,prop] = filterRegions_excludeBorder(imbin);
    else
        [image,prop] = filterRegions_includeBorder(imbin);
    end

    %Below steps are to find location of number plate
    Iprops = regionprops(imbin,'BoundingBox', 'Area', 'Image');
    maxa = Iprops.Area;
    count = numel(Iprops); 
    boundingBox = Iprops.BoundingBox;
    for i=1:count
        if maxa < Iprops(i).Area
            maxa = Iprops(i).Area; 
            boundingBox = Iprops(i).BoundingBox;
            img = Iprops(i).Image;
        end
    end  
    
    [h,w] = size(img);  
    if((w/h > 1.7 && w/h < 3.5) || (w/h > 3.8 && w/h < 4.2) || (w/h > 5 && w/h < 5.4)) 
        imshow(image);
        hold on;
        rectangle('Position',boundingBox, 'EdgeColor','g', 'LineWidth',2);
        img = imcrop(imbin, boundingBox);
        img = bwareaopen(~img, floor(sqrt(h*w)));
        [h,w] = size(img);
            
        if(w/h > 1.7 && w/h < 3.5)
            n = fix(size(img,1)/2);
            img1 = img(1:n,:,:);
            find(img1);
            noPlate1 = noPlate;data:image/pjpeg;base64,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
            img2 = img(n+1:end,:,:);
            find(img2);
            noPlate = [noPlate1 noPlate];BAQEAYABgAAD/2wBD
        else
            if((w/h > 3.8 && w/h < 4.2) || (w/h > 5 && w/h < 5.4))
                find(img);
            end
        end
        hold off;
        drawnow;
        plate = char(noPlate);
        if((size(plate,2) == 9) || (size(plate,2) == 10))
            if(size(plates,1) > 15)
                if(size(plates(15,:),2) ~= size(plate,2))
                    break;
                end
            end
            disp(noPlate);
            plates = [plates; plate];
        end
    end
end    
close;

X = size(plates,1);
Y = size(plates,2);
a = [];
numPlate = [];
for i = 1:Y
    for j = 1:X
        a(j) = plates(j,i);
    end
numPlate = [numPlate char(mode(a))];
end

disp("The no. plate is ");
disp(numPlate);


function find(im)
global noPlate;
noPlate = [];

[h,w] = size(im);
Iprops = regionprops(im,'BoundingBox','Area', 'Image'); 
count = numel(Iprops); 

for i=1:count
   ow = length(Iprops(i).Image(1,:));
   oh = length(Iprops(i).Image(:,1));
   if ow < (w/3) && oh > (h/3)
       Iprops(i).Image = imresize(Iprops(i).Image, [84 44]);
       letter = Letter_detection(Iprops(i).Image); % Reading the letter corresponding the binary image 'N'.
       noPlate = [noPlate letter]; % Appending every subsequent character in noPlate variable. 
   end
end 
end
