load('HOGspeedall.mat');		% In my database, HOGspeedall, it is 8580*6777, 8580 is the number of objects , and 6777 is the length of every object.
								% If you do not want to change the code, you can transform your matrix, to let every object be row vector
X = HOGX;						
[coeff,score,latent,tsquared,explained] = pca(X);
idx = find(cumsum(explained)>95,1)			% Here, you can change the percentage value, '95' to other value you need
train_data = score(:,1:968);        %22*22*2
load HOG14testnew.mat
Y1 = Y(1:2500,:);
train_data_final = [Y1,train_data];
save train_data_final train_data_final;

coeff1 = coeff(:,1:idx);
% score_test = bsxfun(@minus,HOGX,mean(HOGX,1))*coeff;
mean = mean(HOGX,1);

load('HOGtestX.mat')
% R = cov(train_data');
% [U D ~] = svd(R, 'econ');
% T = U * inv (sqrt(D)) * U';
% train_data_white = T * train_data;

test_data = bsxfun(@minus,HOGtestX,mean)*coeff1;
load PCAtest100.mat
Y2 = Y(1:500);
test_data_final = [Y2,test_data];
save test_data_final test_data_final;
result = ELM('train_data_final','test_data_final',1,8000,'sig');            % maximum  up to  0.8540

