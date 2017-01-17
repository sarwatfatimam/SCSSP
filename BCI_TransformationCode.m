function [TypeOne,TypeTwo] = BCI_TransformationCode()
load('C:\Users\Sarwat\Desktop\BCI-Project\covariancetoolbox-master\examples\data\MotorImagery.mat');

% Data formating
COVtest = data.data(:,:,data.idxTest);
trueYtest  = data.labels(data.idxTest);

COVtrain = data.data(:,:,data.idxTraining);
Ytrain  = data.labels(data.idxTraining);

%Separating Left & Right Classes
ixtrain = (Ytrain==1)|(Ytrain==2);
ixtest = (trueYtest==1)|(trueYtest==2);

X1 = COVtrain(:,:,ixtrain);
Y1 = Ytrain(ixtrain,1);

X2 = COVtest(:,:,ixtest);
Y2 = trueYtest(ixtest,1);

X = cat(3,X1,X2);
Y = [Y1; Y2];

TypeOne = cell(1,[]);
TypeTwo = cell(1,[]);

for i = 1:length(X1)
    TypeOne{1,i} = X1(:,:,i);
    TypeTwo{1,i} = X2(:,:,i);
end