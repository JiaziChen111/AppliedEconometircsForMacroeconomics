% First write the OLS function in the file olsfunction.m

% Set up the Data, US GDP in y, consumption in c and investment in in
y=csvread('usgdp.csv');
c=xlsread('uscomp.xlsx','Sheet1');
in=xlsread('uscomp.xlsx','Sheet2');
%  Make the grwoth rates by taking the log differences
dy = log(y(2:end))-log(y(1:end-1));
dc = log(c(2:end))-log(c(1:end-1));
din = log(in(2:end))-log(in(1:end-1));

% Estimate the model
res_c = olsfunction(dc,[ones(size(dy,1),1) dy]);
res_in = olsfunction(din,[ones(size(dy,1),1) dy]);
disp(['Consumption: ' num2str(res_c.beta(2))]);
disp(['Investment:  ' num2str(res_in.beta(2))]);

% Plot the fitted model
figure(1)
    subplot(1,2,1)
        plot([dc res_c.yhat])
        axis([1 size(dc,1) -.2 .15])
        title('Consumption')
    subplot(1,2,2)
        plot([din res_in.yhat])
        axis([1 size(dc,1) -.2 .15])
        title('Investment')


%% Plot residuals
figure(2)
    subplot(1,2,1)
        plot([dc-res_c.yhat])
        axis([1 size(dc,1) -.2 .15])
        title('Consumption')
    subplot(1,2,2)
        plot([din-res_in.yhat])
        axis([1 size(dc,1) -.2 .15])
        title('Investment') 



