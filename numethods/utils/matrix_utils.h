#ifndef MATRIX_UTILS_H
#define MATRIX_UTILS_H

#include <vector>
#include <stdexcept>
#include <random>
#include <cmath>

using ld = long double;
using Vector = std::vector<ld>;
using Matrix = std::vector<std::vector<ld>>;

Matrix generateRandomDiagonalMatrix(int n);

Matrix generateRandomMatrix(int n);

Matrix multiplyMatrixs(const Matrix& A, const Matrix& B);

Vector multiplyMatrixs(const Matrix& A, const Vector& x);

Matrix inverseMatrix(const Matrix& input);

Matrix initWorkMatrix(int n);

void printMatrix(const Matrix& matrix);

#endif // MATRIX_UTILS_H