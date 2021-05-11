clear all;
clc;
cd BioSd\back_propagation\
%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Training\glioma_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);
A=zeros(1,400);
y=zeros();
for k=1:resimSayisi
    string = [dosyayeri,icerik(k,1).name];
    resim=imread(string);
    resim=rgb2gray(resim);
%     resim=imbinarize(resim);
    resim=imresize(resim,[20 20]);
    resim=double(resim);
    resim=reshape(resim,[],1);
    A(k,:)=resim;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Training\meningioma_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);

for i=1:resimSayisi
    string = [dosyayeri,icerik(i,1).name];
    resim=imread(string);
    resim=rgb2gray(resim);
%     resim=imbinarize(resim);
    resim=imresize(resim,[20 20]);
    resim=double(resim);
    resim=reshape(resim,[],1);
    A(k+i,:)=resim;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Training\no_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);

for j=1:resimSayisi
    string = [dosyayeri,icerik(j,1).name];
    resim=imread(string);
    resim=rgb2gray(resim);
%     resim=imbinarize(resim);
    resim=imresize(resim,[20 20]);
    resim=double(resim);
    resim=reshape(resim,[],1);
    A(k+i+j,:)=resim;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Training\pituitary_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);

for t=1:resimSayisi
    string = [dosyayeri,icerik(t,1).name];
    resim=imread(string);
    resim=rgb2gray(resim);
%     resim=imbinarize(resim);
    resim=imresize(resim,[20 20]);
    resim=double(resim);
    resim=reshape(resim,[],1);
    A(k+i+j+t,:)=resim;    
end
y=[ones(1,826),2*ones(1,822),3*ones(1,395),4*ones(1,827)];
save A
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
Aval=zeros(1,400);
yval=zeros();

for k=1:resimSayisi
    string = [dosyayeri,icerik(k,1).name];
    resim=imread(string);
    resim=rgb2gray(resim);
%     resim=imbinarize(resim);
    resim=imresize(resim,[20 20]);
    resim=double(resim);
    resim=reshape(resim,[],1);
    Aval(k,:)=resim;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Testing\meningioma_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);

for i=1:resimSayisi
    string = [dosyayeri,icerik(i,1).name];
    resim=imread(string);
    resim=rgb2gray(resim);
%     resim=imbinarize(resim);
    resim=imresize(resim,[20 20]);
    resim=double(resim);
    resim=reshape(resim,[],1);
    Aval(k+i,:)=resim;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Testing\no_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);

for j=1:resimSayisi
    string = [dosyayeri,icerik(j,1).name];
    resim=imread(string);
    resim=rgb2gray(resim);
%     resim=imbinarize(resim);
    resim=imresize(resim,[20 20]);
    resim=double(resim);
    resim=reshape(resim,[],1);
    Aval(k+i+j,:)=resim;    
end

dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Testing\pituitary_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);

for t=1:resimSayisi
    string = [dosyayeri,icerik(t,1).name];
    resim=imread(string);
    resim=rgb2gray(resim);
%     resim=imbinarize(resim);
    resim=imresize(resim,[20 20]);
    resim=double(resim);
    resim=reshape(resim,[],1);
    Aval(k+i+j+t,:)=resim;    
end
yval=[ones(1,k),2*ones(1,i),3*ones(1,j),4*ones(1,t)];
save Aval
save yval