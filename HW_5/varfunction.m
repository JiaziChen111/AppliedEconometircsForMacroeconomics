function res = varfunction(X,p,d,argp)

    % Input check if d=2 add deterministic trend if d >= 1 ass just constants
    if nargin<3
        disp('Please specify all required input arguments!');
        return
    end

    % K is the number of variables, Setup the Y matrix, construct the Z matrix with the corresponding 		lag level
    K=size(X,2);
    Y=X(p+1:end,:);
    T=size(Y,1);
    Z=nan(T,p*K);
    for ii=1:p
        Z(:,(ii-1)*K+1:ii*K)=X(p+1-ii:end-ii,:);
    end

    % Add deterministic elements if requested
    if d==2
        Z=[Z linspace(1,T,T)'];
    end
    if d>=1
        Z=[Z ones(T,1)];
    end

    Y=Y';
    Z=Z';
    
    % Estimate the model by OLS
    A=Y*Z'/(Z*Z');
    
    % Compute estimate of covariance matrix
    E=Y-A*Z;
    Sigma=(1/(T-p*K-d*K))*(E*E');
    
    % Save the results in an structural Array
    res.A=A;
    res.nobs=T;
    res.Sigma=Sigma;
    res.yhat=A*Z;
    res.like=-(T*K)/2*(1+log(2*pi))-T/2*log(det(Sigma));
    res.AIC=-2*res.like/T+2*(p*K^2+d*K)/T;
    res.BIC=-2*res.like/T+(p*K^2+d*K)*log(T)/T;
         
 

