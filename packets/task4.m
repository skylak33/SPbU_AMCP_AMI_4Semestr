% Определяем диапазон значений для x и y
[x, y] = meshgrid(-25:0.5:25, -25:0.5:25);

z = x.^2/4 + y.^2/9;

% Строим поверхность
figure;
surf(x, y, z, 'FaceColor', 'blue');   
hold on;

x = -25:0.1:25;

f1 = (x.^2 + x) ./ (x.^2 -3*x + 2);
f2 = 2 - 2*sin(x);

plot(x, f1, 'r-', 'LineWidth', 1);
plot(x, f2, 'g--', 'LineWidth', 2);
hold off;

% Настраиваем внешний вид графика
xlabel('x');
ylabel('y');
zlabel('z');
axis equal;
axis([-25 25 -25 25 0 50])

title(['ГРафИки']);
shading interp;   % сглаживание цветов  
legend('$z = \frac{x^2}{4} + \frac{y^2}{9}$', '$y = \frac{x^{2}+x}{x^{2}-3x+2}$', '$y = 2 - 2\sin{x}$', 'Interpreter', 'latex');
grid on;
%caxis([0 50]); % чисто поиграться с цветами
%colorbar; 
