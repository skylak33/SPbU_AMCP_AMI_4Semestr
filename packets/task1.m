function answer = task1(str)
    answer = {};
    idx = 0;

    for k = 1:length(str)
        ch = str(k);
        if_exists = false;

        for l = 1:idx
            if (answer{l}{1} == ch)
                answer{l}{2} = answer{l}{2} + 1;
                if_exists = true;
                break;
            end
        end

        if (~if_exists)
            idx = idx + 1;
            answer{idx} = {ch, 1};
        end
    end
end