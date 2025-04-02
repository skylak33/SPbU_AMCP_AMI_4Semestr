function A = initWorkMatrix()
    n = 3;
    C = 10 * rand(n);
    L = diag(10 * rand(n,1));
    A = C * L * inv(C);

