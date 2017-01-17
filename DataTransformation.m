% Face (class 1) = mTypeOne % Scramble (class 0) = mTypeTwo
% Step 1: Separate Face & Scrambled Face from Y, Add corresponding epochs in type
% one and type two from X
function [mTypeOne, mTypeTwo] = DataTransformation(X, y, sfreq, tmax, tmin, tmin_original); 
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
features = permute(reshape(features, size(X,1), size(X,2),size(XX,3)), [1 2 3]);

mTypeOne={}; mTypeTwo={}; 
f1 = find(y == 1); f0 = find(y == 0); 

for i = 1:length(f1)
    mTypeOne{1,i} = reshape(features(f1(i,1),:,:), size(features,2), size(features,3));
end

for i = 1:length(f0)
    mTypeTwo{1,i} = reshape(features(f0(i,1),:,:), size(features,2), size(features,3));
end


