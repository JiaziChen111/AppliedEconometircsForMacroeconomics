% Bootstrapping of t-values and confidence intervals is the goal of the exercise

% Generate artificial data S
P = normrnd(0,1,1000,1);
% Draw 100 samples
S = nan(50,100);
for ii=1:100
    S(:,ii)=datasample(P,50);
end


% Generate second artifical data according to 
T=50;
B=1000;
e=rand(T,1)*2-1;
y=nan(T,1);
y(1)=.5;
for tt=2:T
    y(tt)=.1+.8*y(tt-1)+e(tt);
end

% Estimate the model with OLS, here build-in matlab ols, own function would be ok as well
resols=ols(y(2:end),[ones(T-1,1) y(1:end-1)]);
disp(['T-statistic is:' num2str(resols.tstat(2))]);

% Bootstrap  different residual samples 
resH0=ols(y(2:end),ones(T-1,1));
e_b=nan(T-1,B);
for ii=1:B
    e_b(:,ii) = datasample(resH0.resid,T-1);
end


% Bootstrap t-statistics
tstat=nan(B,1);
beta=nan(B,1);
y_b=y;
for ii=1:B
    % Generate artifical data set (under the null hypothesis)
    for tt=2:T
        y_b(tt)=resols.beta(1)+0*y_b(tt-1)+e_b(tt-1,ii);
    end
    % Estimate (full) model based on artifical data (generated under H0)
    res_b=ols(y_b(2:end),[ones(T-1,1) y_b(1:end-1)]);
    % Save relevant t-statistic
    tstat(ii)=res_b.tstat(2);
    beta(ii)=res_b.beta(2);
end
