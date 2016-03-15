% Reestimation of the model by Leduc and Sill: 

% Read the data:
eu = xlsread('LeducSillData.xls', 'Matlab','B2:B162');
pdot = xlsread('LeducSillData_2.xls', 'Matlab','C2:C162');
r = xlsread('LeducSillData.xls', 'Matlab','D2:D162');
u = xlsread('LeducSillData.xls', 'Matlab','E2:E162');

% Estimate the Vector autoregressive model. The lag level is 4 according to the paper
var4 = varfunction(y,4,1); 

% Cholesky decomposition
C=chol(var4.Sigma)';

% Forecast error response function
Phi=zeros(4,4,24);
Phi(:,:,1)=eye(4);	% Set the identity matrix for the first period
for ii=1:23             % Loop over the Period, in the paper 24 periods, thus loop over 23 periods 				plus the identiy matrix
    for jj=1:ii         % 
        if jj<=4        % Lags
            Phi(:,:,ii+1)=Phi(:,:,ii+1)+Phi(:,:,ii-jj+1)*var4.A(:,(jj-1)*4+1:jj*4);
        end        
    end
end


% Compute structural impulse response functions for every period
for ii=1:24
    Phi(:,:,ii)=Phi(:,:,ii)*C;
end
fac=Phi(1,1,1);
Phi=Phi./(-1*fac);

% Re-organize those and make plot given by university
Phi=shiftdim(Phi,1);
figure(2);
subplot(4,1,1)
    plot(Phi(1,:,1))
    title(labs{1});
subplot(4,1,2)
    plot(Phi(1,:,4))
    title(labs{4});
subplot(4,1,3)
    plot(Phi(1,:,2))
    title(labs{2});
subplot(4,1,4)
    plot(Phi(1,:,3))
    title(labs{3});




