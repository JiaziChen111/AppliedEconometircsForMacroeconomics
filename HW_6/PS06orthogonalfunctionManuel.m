function res = PS06orthogonalfunctionManuel(dimension)
    % Create Matrix with the dimension n*n and fill the matrix with a
    % normaldistribution with mean = 0 and variance of 1.
    A = normrnd(0,1,dimension,dimension);   
    %Calculate QR Decomposition of A, Q is the orthogonal Matrix.
    [Q, R] = qr(A);
    res.Q = Q;
    
    
