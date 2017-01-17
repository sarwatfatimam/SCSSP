function [features] = createFeatures(XX,tmin, tmax, sfreq,tmin_original)
%Creation of the feature space:
%- restricting the time window of MEG data to [tmin, tmax]sec.
%- Concatenating the 306 timeseries of each trial in one long vector.
%- Normalizing each feature independently (z-scoring
tmin_original = -0.5;
load('train_subject01.mat');
disp('Applying the desired time window.')
beginning = (tmin - tmin_original) * sfreq+1;
e = (tmax - tmin_original) * sfreq;
XX = X(:, :, beginning:e);
disp('2D Reshaping: concatenating all 306 timeseries.');
features = single(zeros(size(XX,1),size(XX,2)*size(XX,3)));
for i = 1 : size(XX,1)
    temp = squeeze(XX(i,:,:));
    features(i,:) = temp(:); 
end
disp('Features Normalization.');
for i = 1 : size(features,2)
    features(:,i) = features(:,i)-mean(features(:,i));
    features(:,i) = features(:,i)./std(features(:,i));
end
disp('Converting back to 3D matrix');
features = permute(reshape(features, 594, 306, 375), [1 2 3]);
end