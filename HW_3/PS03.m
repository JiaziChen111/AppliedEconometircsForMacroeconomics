% Application of the Augmented Dickey Fuller Test:

y=csvread('usgdp.csv');
lny = log(y);
dlny = log(y(2:end))-log(y(1:end-1));

% Dickey Fuller Test
adf_lny_t = adf(lny,1,4);
adf_lny_c = adf(lny,0,4);
adf_dlny_c = adf(dlny,0,4);

% Print Test Result
prt(adf_lny_t,'log GDP');
prt(adf_lny_c,'log GDP');
prt(adf_dlny_c,'log diff GDP');

% Write Function for VAR model in varfunction.m

% Test the VAR function with Stock and Watson Data
% Read the data with the variables u = unemployment, R = interest rate, and p = gdp deflator
[num,string]=xlsread('StockWatsonData.xls','Matlab');
u=num(2:end,2);
R=num(2:end,3);
p=400*log(num(2:end,1)./num(1:end-1,1));

% Estimate the model on a smaller data sample
res_sw=varfunction([p(1:163) u(1:163) R(1:163)],4,1);

% Estimate the mdoel using the full data sample
res_full=myvar([p u R],4,1);

