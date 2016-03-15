%PS 1: 
clear;  
clc; 

% Generates 100x1 vector of random draws
A=normrnd(0,1,100,1);
B=normrnd(1,2,100,1);
S=A+B;
c=A'*B;
%Cumultative Sum
D=cumsum(A);
E1=[2.45 24 124 1 1];
E2=[2.45 24 124 1 1]';

%2 Solutions for the same problem: Create Vector [-5 -4.5 ... 5] in 0.5 steps
F=linspace(-5,5,21);
Falt=-5:.5:5;

%Produce matrices
aMat=ones(2,2)*2;
bMat=nan(2,3);
cMat=[1 3.4 5.43;3 7.5 3.74];
dMat=reshape(linspace(1,100),10,10);

%Produce a random 10x2 matrix
M1 = rand(10,2)*10;
disp(M1);
%Produce a normally distributed random matrix 10x3
M2 = normrnd(0,1,10,3);
disp([M1 M2]);


%% Some Loops
for i=1:100
    disp(i);
end

% Counts in step size of 10 
for i=1:10:111
    disp(i);
end

% Produce 50x1 vector with NAN entries. In each iteration produce for entry i a normally random variable
vector = nan(50,1);
for i=1:50
    vector(i) = normrnd(0,i);
end



%% Introduction of cell Arrays. Each entry is again a normal random variable of dimension ixi
CellArr = {};
for i=1:10
   CellArr(i) = {normrnd(0,sqrt(i),i,i)};   
end


