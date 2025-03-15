function d = task6(A)
    [n, m] = size(A);
    if n ~= m
        error('Матрица должна быть квадратной');
    end

    if n == 1
        d = A(1,1);
    elseif n == 2
        d = A(1,1)*A(2,2) - A(1,2)*A(2,1);
    else
        d = 0;
        for j = 1:n
            minor = A(2:end, [1:j-1, j+1:end]);
            d = d + (-1)^(1+j) * A(1,j) * task6(minor);
        end
    end    
end