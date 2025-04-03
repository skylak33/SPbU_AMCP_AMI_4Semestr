function A = initWorkMatrix()
    n = 3;
    C = 10 * rand(n);
    L = diag(10 * rand(n,1))
    A = C * L * inv(C);
end 
function A = initWorkMatrix2()
    n = 3;
    C = 10 * rand(n);
    L = diag(10 * rand(n,1));
    L(3,3) = -L(3,3);
    L([2,3], :) = L([3,2], :);
    A = C * L * inv(C);
end