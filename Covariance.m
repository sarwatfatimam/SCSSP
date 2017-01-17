function[CTypeOneSpectral, CTypeOneSpatial, CTypeTwoSpectral, CTypeTwoSpatial] = Covariance(fTypeOne,fTypeTwo)
%Transposing 3D matrix
TypeOneT = permute(fTypeOne, [2,1,3]);
TypeTwoT = permute(fTypeTwo, [2,1,3]);

Nch = length(fTypeOne(1,:,1));
Nf  = length(fTypeOne(:,1,1));
Nt = length(fTypeOne(1,1,:));
spe = 0; spa = 0;

%Calculate the spatial & spectral covariance 

for j = 1:size(fTypeOne,3);
    %spectral covariance
    spe1 = fTypeOne(:,:,j)*TypeOneT(:,:,j); 
    spe = spe+spe1; 
         
    %spatial covariance
    spa1 = TypeOneT(:,:,j)*fTypeOne(:,:,j); 
    spa = spa+spa1; 
end

%spectral covariance
CTypeOneSpectral = (1/Nf*Nt)*spe;
%spatial covariance
CTypeOneSpatial = (1/Nch*Nt)*spa;

%TypeTwo

for j = 1:size(fTypeTwo,3);
    %spectral covariance
    spe1 = fTypeTwo(:,:,j)*TypeTwoT(:,:,j); 
    spe = spe+spe1; 
         
    %spatial covariance
    spa1 = TypeTwoT(:,:,j)*fTypeTwo(:,:,j); 
    spa = spa+spa1; 
end

%spectral covariance
CTypeTwoSpectral = (1/Nf*Nt)*spe;
%spatial covariance
CTypeTwoSpatial = (1/Nch*Nt)*spa;

end