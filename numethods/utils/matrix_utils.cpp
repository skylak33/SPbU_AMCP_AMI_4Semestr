#include <vector>
#include <stdexcept>
#include <random>
#include <iostream>

using ld = long double;
using Vector = std::vector<ld>;
using Matrix = std::vector<std::vector<ld>>;

Matrix generateRandomDiagonalMatrix(int n) {
    Matrix matrix(n, Vector(n, 0));
    
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(-100, 100); 
    
    // Генерируем случайные значения только по диагонали
    for (int i = 0; i < n; i++) {
        matrix[i][i] = dis(gen);
    }
    
    return matrix;
}

Matrix generateRandomMatrix(int n) {
    Matrix matrix(n, Vector(n, 0));
    
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(-100, 100); 
    
    // Генерируем случайные значения
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            matrix[i][j] = dis(gen);
        }
    }
    
    return matrix;
}

Matrix multiplyMatrixs(const Matrix& A, const Matrix& B) {
    int n = A.size();
    int p = A[0].size();
    int m = B[0].size();

    // Проверяем совместимость размеров: если A имеет размер n x m, то B должна иметь размер m x p
    if (p != B.size()) {
        throw std::invalid_argument("Невозможно перемножить матрицы");
    }

    Matrix result(n, Vector(m, 0));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            for (int k = 0; k < p; k++) {
                result[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    return result;
}
Vector multiplyMatrixs(const Matrix& A, const Vector& x) {
    size_t n = A.size();
    Vector result(n, 0.0);
    for (size_t i = 0; i < n; ++i)
        for (size_t j = 0; j < n; ++j)
            result[i] += A[i][j] * x[j];
    return result;
}

Matrix inverseMatrix(const Matrix& input) {
    int n = input.size();
    
    auto A = input;
    
    // Создаем единичную матрицу
    Matrix inv(n, Vector(n, 0));
    for (int i = 0; i < n; i++) {
        inv[i][i] = 1.0;
    }
    
    // Прямой и обратный ход метода Гаусса–Жордана
    for (int i = 0; i < n; i++) {
        double pivot = A[i][i];
        // Если опорный элемент равен нулю, пытаемся поменять строки местами
        if (std::fabs(pivot) < 1e-9) {
            bool swapped = false;
            for (int j = i + 1; j < n; j++) {
                if (std::fabs(A[j][i]) > 1e-9) {
                    std::swap(A[i], A[j]);
                    std::swap(inv[i], inv[j]);
                    pivot = A[i][i];
                    swapped = true;
                    break;
                }
            }
            if (!swapped) {
                throw std::runtime_error("Матрица вырождена, обратная не существует");
            }
        }
        // Нормализуем строку так, чтобы опорный элемент стал равен 1
        for (int j = 0; j < n; j++) {
            A[i][j] /= pivot;
            inv[i][j] /= pivot;
        }
        // Обнуляем столбец i во всех остальных строках
        for (int k = 0; k < n; k++) {
            if (k == i) continue;
            double factor = A[k][i];
            for (int j = 0; j < n; j++) {
                A[k][j] -= factor * A[i][j];
                inv[k][j] -= factor * inv[i][j];
            }
        }
    }
    
    return inv;
}

Matrix initWorkMatrix(int n) {
    auto L = generateRandomDiagonalMatrix(3);
    auto C = generateRandomMatrix(3);
    auto C_inv = inverseMatrix(C);
    auto A = multiplyMatrixs(multiplyMatrixs(C_inv, L), C);
    return A;
}

void printMatrix(const Matrix& matrix) {
    for (const auto& row : matrix) {
        for (const auto& elem : row) {
            std::cout << elem << " ";
        }
        std::cout << std::endl;
    }
}
