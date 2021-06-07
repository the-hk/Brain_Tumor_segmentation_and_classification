clear all;
clc;
% cd BioSd\LastProject\

workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;
% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
  % User does not have the toolbox installed.
  message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
  reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
  if strcmpi(reply, 'No')
    % User said No, so exit.
    return;
  end
end

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Training\glioma_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);
y=zeros();
soi=50;
counter=0;
var=400;
for k=1:resimSayisi
    counter=counter+1;
    string = [dosyayeri,icerik(k,1).name];
    resim=imread(string);
%     resim=imresize(resim,[var var]);
    A=double(resim);
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

Kmedian1 = medfilt2(A(:,:,1));
Kmedian2 = medfilt2(A(:,:,2));
Kmedian3 = medfilt2(A(:,:,3));

adaptHisteq = adapthisteq(Kmedian1);
adaptHisteq2 = adapthisteq(Kmedian2);
adaptHisteq3 = adapthisteq(Kmedian3);


A(:,:,1)=adaptHisteq;
A(:,:,2)=adaptHisteq2;
A(:,:,3)=adaptHisteq3;
grayImage=255*rgb2gray(A);
% Crop image to get rid of light box surrounding the image
grayImage = grayImage(3:end-3, 4:end-4);
% Threshold to create a binary image
% soi=255*graythresh(grayImage);
binaryImage = grayImage > soi;
% Get rid of small specks of noise
binaryImage = bwareaopen(binaryImage, 10);
% Display the original gray scale image.

% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');

% Erode away 15 layers of pixels.
se = strel('disk', 15, 0);
binaryImage = imerode(binaryImage, se);

% Mask the gray image
finalImage = grayImage; % Initialize.
finalImage(~binaryImage) = 0;
% imshow(finalImage);
% pause(2)
[glcm,SI] = graycomatrix(uint8(finalImage),'Offset',[2 0],'Symmetric',true);

glcm=transpose(glcm(:));


train(k,:)=glcm;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Training\meningioma_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);
counter=0;
for i=1:resimSayisi
    counter=counter+1;

    string = [dosyayeri,icerik(i,1).name];
    resim=imread(string);
%     resim=imresize(resim,[var var]);
    A=double(resim);
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

Kmedian1 = medfilt2(A(:,:,1));
Kmedian2 = medfilt2(A(:,:,2));
Kmedian3 = medfilt2(A(:,:,3));

adaptHisteq = adapthisteq(Kmedian1);
adaptHisteq2 = adapthisteq(Kmedian2);
adaptHisteq3 = adapthisteq(Kmedian3);


A(:,:,1)=adaptHisteq;
A(:,:,2)=adaptHisteq2;
A(:,:,3)=adaptHisteq3;
grayImage=255*rgb2gray(A);
% Crop image to get rid of light box surrounding the image
grayImage = grayImage(3:end-3, 4:end-4);
% Threshold to create a binary image
% soi=255*graythresh(grayImage);

binaryImage = grayImage > soi;
% Get rid of small specks of noise
binaryImage = bwareaopen(binaryImage, 10);
% Display the original gray scale image.

% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');

% Erode away 15 layers of pixels.
se = strel('disk', 15, 0);
binaryImage = imerode(binaryImage, se);

% Mask the gray image
finalImage = grayImage; % Initialize.
finalImage(~binaryImage) = 0;

[glcm,SI] = graycomatrix(uint8(finalImage),'Offset',[2 0],'Symmetric',true);
glcm=transpose(glcm(:));



train(k+i,:)=glcm;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Training\no_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);
counter=0;
for j=1:resimSayisi
    counter=counter+1;

    string = [dosyayeri,icerik(j,1).name];
    resim=imread(string);
%     resim=imresize(resim,[var var]);
    A=double(resim);
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

Kmedian1 = medfilt2(A(:,:,1));
Kmedian2 = medfilt2(A(:,:,2));
Kmedian3 = medfilt2(A(:,:,3));

adaptHisteq = adapthisteq(Kmedian1);
adaptHisteq2 = adapthisteq(Kmedian2);
adaptHisteq3 = adapthisteq(Kmedian3);


A(:,:,1)=adaptHisteq;
A(:,:,2)=adaptHisteq2;
A(:,:,3)=adaptHisteq3;
grayImage=255*rgb2gray(A);
% Crop image to get rid of light box surrounding the image
grayImage = grayImage(3:end-3, 4:end-4);
% Threshold to create a binary image
% soi=255*graythresh(grayImage);

binaryImage = grayImage > soi;
% Get rid of small specks of noise
binaryImage = bwareaopen(binaryImage, 10);
% Display the original gray scale image.

% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');

% Erode away 15 layers of pixels.
se = strel('disk', 15, 0);
binaryImage = imerode(binaryImage, se);

% Mask the gray image
finalImage = grayImage; % Initialize.
finalImage(~binaryImage) = 0;

[glcm,SI] = graycomatrix(uint8(finalImage),'Offset',[2 0],'Symmetric',true);
glcm=transpose(glcm(:));

train(k+i+j,:)=glcm;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Training\pituitary_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);
counter=0;
for t=1:resimSayisi
    counter=counter+1;

    string = [dosyayeri,icerik(t,1).name];
    resim=imread(string);
%     resim=imresize(resim,[var var]);
    A=double(resim);
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

Kmedian1 = medfilt2(A(:,:,1));
Kmedian2 = medfilt2(A(:,:,2));
Kmedian3 = medfilt2(A(:,:,3));

adaptHisteq = adapthisteq(Kmedian1);
adaptHisteq2 = adapthisteq(Kmedian2);
adaptHisteq3 = adapthisteq(Kmedian3);


A(:,:,1)=adaptHisteq;
A(:,:,2)=adaptHisteq2;
A(:,:,3)=adaptHisteq3;
grayImage=255*rgb2gray(A);
% Crop image to get rid of light box surrounding the image
grayImage = grayImage(3:end-3, 4:end-4);
% Threshold to create a binary image
% soi=255*graythresh(grayImage);

binaryImage = grayImage > soi;
% Get rid of small specks of noise
binaryImage = bwareaopen(binaryImage, 10);
% Display the original gray scale image.

% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');

% Erode away 15 layers of pixels.
se = strel('disk', 15, 0);
binaryImage = imerode(binaryImage, se);

% Mask the gray image
finalImage = grayImage; % Initialize.
finalImage(~binaryImage) = 0;

[glcm,SI] = graycomatrix(uint8(finalImage),'Offset',[2 0],'Symmetric',true);
glcm=transpose(glcm(:));


train(k+i+j+t,:)=glcm;    
end
y=[ones(1,k),2*ones(1,i),3*ones(1,j),4*ones(1,t)];
save train
save y

k=0;
i=0;
j=0;
t=0;
dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Testing\glioma_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);
yval=zeros();
counter=0;
for k=1:resimSayisi
    counter=counter+1;

    string = [dosyayeri,icerik(k,1).name];
    resim=imread(string);
%     resim=imresize(resim,[var var]);
    A=double(resim);
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

Kmedian1 = medfilt2(A(:,:,1));
Kmedian2 = medfilt2(A(:,:,2));
Kmedian3 = medfilt2(A(:,:,3));

adaptHisteq = adapthisteq(Kmedian1);
adaptHisteq2 = adapthisteq(Kmedian2);
adaptHisteq3 = adapthisteq(Kmedian3);


A(:,:,1)=adaptHisteq;
A(:,:,2)=adaptHisteq2;
A(:,:,3)=adaptHisteq3;
grayImage=255*rgb2gray(A);
% Crop image to get rid of light box surrounding the image
grayImage = grayImage(3:end-3, 4:end-4);
% Threshold to create a binary image
% soi=255*graythresh(grayImage);

binaryImage = grayImage > soi;
% Get rid of small specks of noise
binaryImage = bwareaopen(binaryImage, 10);
% Display the original gray scale image.

% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');

% Erode away 15 layers of pixels.
se = strel('disk', 15, 0);
binaryImage = imerode(binaryImage, se);

% Mask the gray image
finalImage = grayImage; % Initialize.
finalImage(~binaryImage) = 0;

[glcm,SI] = graycomatrix(uint8(finalImage),'Offset',[2 0],'Symmetric',true);
glcm=transpose(glcm(:));
Aval(k,:)=glcm;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Testing\meningioma_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);
counter=0;
for i=1:resimSayisi
    counter=counter+1;

    string = [dosyayeri,icerik(i,1).name];
    resim=imread(string);
%     resim=imresize(resim,[var var]);
    A=double(resim);
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

Kmedian1 = medfilt2(A(:,:,1));
Kmedian2 = medfilt2(A(:,:,2));
Kmedian3 = medfilt2(A(:,:,3));

adaptHisteq = adapthisteq(Kmedian1);
adaptHisteq2 = adapthisteq(Kmedian2);
adaptHisteq3 = adapthisteq(Kmedian3);


A(:,:,1)=adaptHisteq;
A(:,:,2)=adaptHisteq2;
A(:,:,3)=adaptHisteq3;
grayImage=255*rgb2gray(A);
% Crop image to get rid of light box surrounding the image
grayImage = grayImage(3:end-3, 4:end-4);
% Threshold to create a binary image
% soi=255*graythresh(grayImage);

binaryImage = grayImage > soi;
% Get rid of small specks of noise
binaryImage = bwareaopen(binaryImage, 10);
% Display the original gray scale image.

% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');

% Erode away 15 layers of pixels.
se = strel('disk', 15, 0);
binaryImage = imerode(binaryImage, se);

% Mask the gray image
finalImage = grayImage; % Initialize.
finalImage(~binaryImage) = 0;

[glcm,SI] = graycomatrix(uint8(finalImage),'Offset',[2 0],'Symmetric',true);
glcm=transpose(glcm(:));

    Aval(k+i,:)=glcm;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Testing\no_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);
counter=0;
for j=1:resimSayisi
    counter=counter+1;

    string = [dosyayeri,icerik(j,1).name];
    resim=imread(string);
%     resim=imresize(resim,[var var]);
    A=double(resim);
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

Kmedian1 = medfilt2(A(:,:,1));
Kmedian2 = medfilt2(A(:,:,2));
Kmedian3 = medfilt2(A(:,:,3));

adaptHisteq = adapthisteq(Kmedian1);
adaptHisteq2 = adapthisteq(Kmedian2);
adaptHisteq3 = adapthisteq(Kmedian3);


A(:,:,1)=adaptHisteq;
A(:,:,2)=adaptHisteq2;
A(:,:,3)=adaptHisteq3;
grayImage=255*rgb2gray(A);
% Crop image to get rid of light box surrounding the image
grayImage = grayImage(3:end-3, 4:end-4);
% Threshold to create a binary image
% soi=255*graythresh(grayImage);

binaryImage = grayImage > soi;
% Get rid of small specks of noise
binaryImage = bwareaopen(binaryImage, 10);
% Display the original gray scale image.

% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');

% Erode away 15 layers of pixels.
se = strel('disk', 15, 0);
binaryImage = imerode(binaryImage, se);

% Mask the gray image
finalImage = grayImage; % Initialize.
finalImage(~binaryImage) = 0;

[glcm,SI] = graycomatrix(uint8(finalImage),'Offset',[2 0],'Symmetric',true);
glcm=transpose(glcm(:));

    Aval(k+i+j,:)=glcm;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Testing\pituitary_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);
counter=0;
for t=1:resimSayisi
    counter=counter+1;

    string = [dosyayeri,icerik(t,1).name];
    resim=imread(string);
%     resim=imresize(resim,[var var]);
    A=double(resim);
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

Kmedian1 = medfilt2(A(:,:,1));
Kmedian2 = medfilt2(A(:,:,2));
Kmedian3 = medfilt2(A(:,:,3));

adaptHisteq = adapthisteq(Kmedian1);
adaptHisteq2 = adapthisteq(Kmedian2);
adaptHisteq3 = adapthisteq(Kmedian3);


A(:,:,1)=adaptHisteq;
A(:,:,2)=adaptHisteq2;
A(:,:,3)=adaptHisteq3;
grayImage=255*rgb2gray(A);
% Crop image to get rid of light box surrounding the image
grayImage = grayImage(3:end-3, 4:end-4);
% Threshold to create a binary image
% soi=255*graythresh(grayImage);

binaryImage = grayImage > soi;
% Get rid of small specks of noise
binaryImage = bwareaopen(binaryImage, 10);
% Display the original gray scale image.

% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');

% Erode away 15 layers of pixels.
se = strel('disk', 15, 0);
binaryImage = imerode(binaryImage, se);

% Mask the gray image
finalImage = grayImage; % Initialize.
finalImage(~binaryImage) = 0;

[glcm,SI] = graycomatrix(uint8(finalImage),'Offset',[2 0],'Symmetric',true);
glcm=transpose(glcm(:));

    Aval(k+i+j+t,:)=glcm;    
end
yval=[ones(1,k),2*ones(1,i),3*ones(1,j),4*ones(1,t)];
save crossVal
save yval