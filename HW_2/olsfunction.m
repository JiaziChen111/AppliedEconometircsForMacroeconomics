function results = olsfunction(Y,X)
    % Function calculates the ols estimation of a vector y and explaining variable matrix x.
    results.beta = inv(X'*X)*X'*Y;
    % Residuals
    eps = Y-X*results.beta;
    % Fitted values
    results.yhat = X*results.beta;
    % Number of observations
    results.nobs = size(Y,1);
    % Estimate of residual variance
    s2 = (eps'*eps)/(size(Y,1)-size(X,2));
    % Standard errors for beta
    results.sd = sqrt(diag(s2*inv(X'*X)));
    
