#include "../utils/utils.h"
#include "../utils/matrix_utils.h"
#include <iostream>
using ld = long double;
using Vector = std::vector<ld>;
const ld eps = 1e-9;

void norming(Vector &y) {
    ld norm = 0;
    for (ld val : y) {
        norm += val * val;
    }
    norm = std::sqrt(norm); 
    for (ld &val : y) {
        val /= norm;
    }
}
ld rayleighQuotient(const Vector &x, const std::vector<Vector> &A) {
    Vector Ax = multiplyMatrixs(A, x);  // Вычисляем Ax
    ld numerator = 0, denominator = 0;
    
    for (int i = 0; i < x.size(); i++) {
        numerator   += x[i] * Ax[i];  // x^T * A * x
        denominator += x[i] * x[i];   // x^T * x
    }
    
    return numerator / denominator;
}

int main() { // A = C^-1 * L * C
    int n = 3;
    auto A = initWorkMatrix(n);
    printMatrix(A);
    // Инициализируем начальный вектор (ненулевой) и нормализуем
    Vector x(n, 1.0);
    printVector(x);
    
    ld lamdasum = 0;
    ld lambda = 0, lambda_old = 0;
    int it = 0, max_it = 1000;
    
    while (it < max_it) {
        Vector y = multiplyMatrixs(A, x);
        norming(y); // Высчитываем новую итерацию и нормируем

        // Вычисляем приближение собственного числа через скалярное произведение
        lambda = rayleighQuotient(y, A);

        // Проверка сходимости
        if (std::fabs(lambda - lambda_old) < eps) {
            std::cout << "Сошлось на итерации: " << it << "\n";
            break;
        }
        lambda_old = lambda;
        x = y;
        it++;
    }
    std::cout << "Наибольшее по модулю собственное число: " << lambda << "\n";
    std::cout << "Собственный вектор: ";
    for(auto i : x)
        std::cout << i << " ";
    std::cout << "\n";

}