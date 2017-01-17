addpath('C:\Users\Sarwat\Desktop\Thesis\SCSSP-Algorithm');
clc;
clear all;
disp('loading data')
Data = load('train_subject01.mat');
%Data = load('Subject_01.mat');
tmin = 0;
tmax = 0.5;
[mTypeOne, mTypeTwo] = DataTransformation(Data.X, Data.y, Data.sfreq, tmax, tmin, -0.5); 

%Declaring features cell array for storing features from each epoch
TypeOneZ = cell(1,[]); 
TypeTwoZ = cell(1,[]);

%d discriminant features 
d = 4;

for j = 1:length(mTypeOne);
        TypeOne = mTypeOne{1,j};
        TypeTwo = mTypeTwo{1,j};
        disp('Step 1: Applying Causal Chebyshev Type II Filter to each EEG Epoch');
        [fTypeOne, fTypeTwo] = NfBandPassFilter(TypeOne,TypeTwo); 
        disp('Step 2: Calculate the spectral and spatial covariance');
        [CTypeOneSpectral, CTypeOneSpatial, CTypeTwoSpectral, CTypeTwoSpatial] = Covariance(fTypeOne,fTypeTwo); 
        disp('Step 3: Solve generalized eigen value problem and extract the feature vector'); 
        [z1,z2] = EigenValuesProblem(CTypeOneSpectral, CTypeOneSpatial, CTypeTwoSpectral, CTypeTwoSpatial,fTypeOne,fTypeTwo,d);
        TypeOneZ{1,j} = z1;
        TypeTwoZ{1,j} = z2;
end

CovOne = {}; CovTwo = {};
for i = 1:length(TypeOneZ);
CovOne(:,:,i) = TypeOneZ(1,i); %Class 1
CovTwo(:,:,i) = TypeTwoZ(1,i); %Class 2
end

%%
%Formating Dataset
%X = [Cov1; Cov2];
K = [CovOne; CovTwo];
K = cat(3, K{:}); %Making a 3Dimensional Matrix
for i = 1:size(K,3)
A = reshape(K(:,:,i), 1,[]);
X(i,:) = A;
end
%Y = [zeros((length(X))/2,1); ones((length(X))/2,1)]; %Labels for Class 1 =
%0, Class 2 = 0
Y = [ones((size(X,1))/2,1); (zeros((size(X,1))/2,1))];

