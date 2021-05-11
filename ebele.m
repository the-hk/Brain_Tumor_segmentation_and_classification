
dosyayeri='D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\archive\Training\glioma_tumor\';
dosyaturu='.jpg';

%burada klasörün içindeki jpeg uzantılı dosyaları alıyoruz 
icerik = dir([dosyayeri,'*',dosyaturu]);

resimSayisi = size(icerik,1);
a=0;
for k=1:resimSayisi
    a=a+1;
    string = [dosyayeri,icerik(k,1).name];
    resim=imread(string);
    [J,~] = imcrop(resim);
    name="cropped"+a+".jpg";
    imwrite(J, name);
    imwrite(J, fullfile(dosyayeri , name));

end

