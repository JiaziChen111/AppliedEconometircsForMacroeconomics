%% Solution for Problem Set 6
% Programming Sign Restriction, introduce by Sims

clear;
clc;

%% Problem 1:
%a) See function script

%b)
disp('Problem 1b:')
result = PS06orthogonalfunctionManuel(10);
Q = result.Q
% To check that Q is orthogonal:
Q*Q';


%% Problem 2: 

% Restriction matrix:
R = [1 4 1; 1 1 -1; 0 0 0];
R 

%a) See function script: PS11checkSignManuel(R, IRF)

disp('Problem 2b:')
%b)
sampleData = load('SampleIRFs.mat');
IRF1 = sampleData.irf1;
IRF2 = sampleData.irf2;
IRF3 = sampleData.irf3;
IRF4 = sampleData.irf4;

%Test 1:
IRF1
res = PS06checkSignManuel(R, IRF1);
res.identifier

%Test 2:
IRF2
res = PS06checkSignManuel(R, IRF2);
res.identifier

%Test 3:
IRF3
res = PS06checkSignManuel(R, IRF3);
res.identifier

%Test 4:
IRF4
res = PS06checkSignManuel(R, IRF4);
res.identifier


%% Problem 3:

%a) Load the data:
data = load('Input.mat')
Sigma = data.Sigma;
A = data.A;
Sigma;
A;

%b) IRF for the Sigma Matrix. I use the script of PS 9. 
disp('Problem 3b:')
C=chol(Sigma)';
res = PS06impulseResponseManuel(Sigma,A,C,6,12);
res.Phi

%c)
CellArr = {};
for ii=1:100
    C=chol(Sigma)';
    [m n] = size(C);
    D=PS06orthogonalfunctionManuel(m);
    D=D.Q;
    B=C*D;
    res1 = PS06impulseResponseManuel(Sigma,A,B,6,12);
    CellArr(ii) = {res1.Phi};
end

%d)
figure(1)
for jj=1:100
    res = cell2mat(CellArr(jj));    
    res = shiftdim(res,1);
    plot(res(1,:,1));
    hold on;
end    

