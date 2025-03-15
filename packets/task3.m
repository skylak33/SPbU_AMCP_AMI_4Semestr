function count = task3(a, el)
    [~, n] = size(a);
    left = 0;
    for idx = 1:n
        if a{idx} == el
            left = idx;
            break;
        end
    end
    count = 0;
    for idx = 1:left
        if a{idx} < el
            count = count + 1;
        end
    end
end 