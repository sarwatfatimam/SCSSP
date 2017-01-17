   % The following matlab program is used to implement SCSSP Algorithm 
function [fTypeOne, fTypeTwo] = NfBandPassFilter(TypeOne,TypeTwo)
%Frequency=[4 8; 8 12; 12 16; 16 20; 20 24; 24 28; 28 32; 32 36; 36 40];
%Frequency=[1 4; 4 8; 8 12; 12 16; 16 20];
Frequency=[4 8; 8 12; 12 16; 16 20];
%Frequency=[8 12; 12 16; 16 20; 20 24; 24 28; 28 32];
Fs=250;
Wn = Frequency/(Fs/2);
filt_n = 2;

%Step 1: Applying Causal Chebyshev Type II Filter to each EEG Epoch

for f = 1:length(Frequency);
    %[filter_b,filter_a]= cheby2(2*filt_n,60,Wn(f,:));
    [filter_b,filter_a]= butter(6,Wn(f,:));
    data_filter(f,:,:) = filter(filter_b,filter_a,TypeOne,[],2);
    fTypeOne = data_filter(:,:,:);   
    data_filter(f,:,:) = filter(filter_b,filter_a,TypeTwo,[],2);
    fTypeTwo = data_filter(:,:,:);
end

