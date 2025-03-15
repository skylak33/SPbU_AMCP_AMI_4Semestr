function [left, right] = task3(a, el)
    [~, n] = size(a);
    left = 0;
    for idx = 1:n
        if a{idx} == el
            left = idx - 1;
            break;
        end
    end
    right = n - left - 1;
end 