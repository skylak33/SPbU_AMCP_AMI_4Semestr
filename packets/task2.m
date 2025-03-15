%   Команды для запуска
%   task2(3, {{1, 2, 3}; {2, 3, 1}; {3, 1, 2}}) ans = 1
%   task2(3, {{1, 2, 3}; {2, 2, 3}; {3, 1, 2}}) ans = 0
function answer = task2(N, M)
    % task2 проверяет, является ли массив латинским квадратом.
    % M должен быть массивом размером N×N, содержащим числа от 1 до N,
        [rows, ~] = size(M);
        [~, cols] = size(M{1});
        if rows ~= N || cols ~= N
            error('Размер массива не соответствует указанному N');

        end
        % Проверка строк
        for idx = 1:N 
            for k = 1:N 
                if ~inRange(M{idx}{k}, N)
                    answer = false;
                    return;
                end
                for l = k+1:N
                    if M{idx}{k} == M{idx}{l}
                        answer = false;
                        return;
                    end
                end
            end
        end
        
    % Проверка столбцов
    % тк в прошлом цикле мы проверили что все принаджлежат диапазону от 1 до N 
    % то можно не проверять это в этом цикле
        for idx = 1:N 
            for k = 1:N 
                for l = k+1:N
                    if M{k}{idx} == M{l}{idx}
                        answer = false;
                        return;
                    end
                end
            end
        end
        answer = true;
    end
    
function result = inRange(x, number)
% inRange проверяет, находится ли число x в диапазоне от 1 до N включительно
    if (1 <= x) && (x <= number)
        result = true;
    else
        result = false;
    end
end