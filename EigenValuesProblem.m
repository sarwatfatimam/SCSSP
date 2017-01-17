function [Z1, Z2] = EigenValuesProblem(CTypeOneSpectral, CTypeOneSpatial, CTypeTwoSpectral, CTypeTwoSpatial,fTypeOne,fTypeTwo, d)
 
 Nch = length(CTypeOneSpatial);
 Nf  = length(CTypeOneSpectral);
 lambda_M = zeros(Nf,Nch); %TypeOne
 lambda_N = zeros(Nf,Nch); %TypeTwo
 
 %Spatial Eigen Values
 [Wr1,Vr1]= eig(CTypeOneSpatial,CTypeOneSpatial+CTypeTwoSpatial); %TypeOne
 [Wr2,Vr2]= eig(CTypeTwoSpatial,CTypeTwoSpatial+CTypeOneSpatial); %TypeTwo
 Vr1 = diag(Vr1); 
 Vr2 = diag(Vr2); 
 
 %Spectral Eigen Values
 [Wl1,Vl1]= eig(CTypeOneSpectral,CTypeOneSpectral+CTypeTwoSpectral); %TypeOne
 [Wl2,Vl2]= eig(CTypeTwoSpectral,CTypeTwoSpectral+CTypeOneSpectral); %TypeTwo
 Vl1 = diag(Vl1); 
 Vl2 = diag(Vl2); 
     
 for p = 1:Nf;
     for q = 1:Nch;
     lambda_M(p,q) = (Vl1(p,1)*Vr1(q,1))/(Vl1(p,1)*Vr1(q,1) + (1-Vl1(p,1))*(1-Vr1(q,1)));
     lambda_N(p,q) = (Vl2(p,1)*Vr2(q,1))/(Vl2(p,1)*Vr2(q,1) + (1-Vl2(p,1))*(1-Vr2(q,1)));
     end
 end
     
 lambda_k1 = sort(lambda_M,'descend');
 [Nf_rows_1,Nch_columns_1] = find(lambda_k1);
 
 lambda_k2 = sort(lambda_N,'descend');
 [Nf_rows_2,Nch_columns_2] = find(lambda_k2);
 
 W1 = kron(Wr1,Wl1); %Kronecker Product
 W2 = kron(Wr2,Wl2);
 for i = 1:size(fTypeOne,3)
     y1(:,:,i) = W1'*reshape(fTypeOne(:,:,i),[],1);
     y2(:,:,i) = W2'*reshape(fTypeTwo(:,:,i),[],1);
 end
 
 %Removing Singleton Dimension
 y1 = squeeze(y1(1:d,:)); 
 y2 = squeeze(y2(1:d,:)); 
 
 %Selecting d features
 %y1 = y1(1:d,:,:); 
 %y2 = y2(1:d,:,:); 
 
 Z1 = (log(var(y1)/sum(var(y1))))'; %Features Vector
 Z2 = (log(var(y2)/sum(var(y2))))';
 
 %Z1 = log(var(y1,0,3)/sum(var(y1,0,3))); %Features Vector
 %Z2 = log(var(y2,0,3)/sum(var(y2,0,3)));
 end
 
