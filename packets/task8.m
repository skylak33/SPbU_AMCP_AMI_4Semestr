function answer = task8(n) 
    numstr = num2str(n);
    answer = -Inf

    for (i = 1:length(numstr))
        cStr = [numstr(1:i-1) numstr(i+1:end)];
        cVal = str2double(cStr);
        if cVal > answer
            answer = cVal;
        end
    end
end