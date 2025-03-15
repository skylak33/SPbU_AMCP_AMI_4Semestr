function answer = task7(a)
    [~ , n] = size(a);
    for i = 1:n % пузырек
        for j = i:n
            if a{j} < a{i}
                temp = a{i};
                a{i} = a{j};
                a{j} = temp;
            end
        end
    end
    answer = zeros(0,n);
    for idx = 1 : (n/2)
        answer(2*idx) = a{n - idx + 1}; 
        answer(2*idx - 1)     = a{idx};        
    end

end
% task7({1, 2, 3, 4, 1, 2, 4,2, 6, 1})