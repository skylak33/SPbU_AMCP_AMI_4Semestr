function a = task5(n)
    a = zeros(n, n);

    x = 0; 
    y = 0; 
    s = 0;
    i = 1;
    max_i = floor(n*n/2) + 1; 

    while i <= max_i
        a(y+1, x+1) = i;
        a(n-y, n-x) = n*n + 1 - i;
        i = i + 1;
        
        if s
            x = x + 1;
            s = double(y ~= 0);
            y = y - s;  
        else
            y = y + 1;
            s = double(x == 0); 
            if x ~= 0
                x = x - 1;
            end
        end
    end
end