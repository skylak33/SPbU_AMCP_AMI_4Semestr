function count = task3(a)
    [~, n] = size(a);
    count = zeros(1, n);

    for k = 1:n
        if k == 1
            count(k) = 0;
        else
            count(k) = sum(a(1:k-1) < a(k));
        end
    end
end
