#include <bits/stdc++.h>

using namespace std;
using ld = long double;
const ld PI = 3.14159265f;

ld f(ld x) {
    return x - sin(x) - 0.25f;
}

vector<ld> polynomialMultiplication(const vector<ld>& p1, const vector<ld>& p2) {
    int deg1 = p1.size() - 1;
    int deg2 = p2.size() - 1;
    vector<ld> p(deg1 + deg2 + 1, 0.0f);
    for (int i = 0; i <= deg1; ++i) {
        for (int j = 0; j <= deg2; ++j) {
            p[i + j] += p1[i] * p2[j];
        }
    }
    return p;
}

ld polynomialCalculation(const vector<ld>& p, ld x) {
    ld result = 0.0f;
    int degree = p.size();
    for (int i = 0; i < degree; ++i) {
        result += p[i] * pow(x, degree - 1 - i);
    }
    return result;
}

vector<ld> polynomialAddition(const vector<ld>& p1, const vector<ld>& p2) {
    // Приводим полиномы к одинаковой длине, дополняя нулями в начале
    size_t size1 = p1.size();
    size_t size2 = p2.size();
    size_t maxSize = max(size1, size2);

    vector<ld> poly1(maxSize - size1, 0.0f);
    poly1.insert(poly1.end(), p1.begin(), p1.end());
    vector<ld> poly2(maxSize - size2, 0.0f);
    poly2.insert(poly2.end(), p2.begin(), p2.end());

    vector<ld> sum(maxSize, 0.0f);
    for (size_t i = 0; i < maxSize; ++i) {
        sum[i] = poly1[i] + poly2[i];
    }
    return sum;
}

vector<ld> LagrangePolynomial(const vector<ld>& nodes) {
    int N = nodes.size();
    vector<ld> L(N, 0.0f);
    vector<vector<ld>> basis(N, vector<ld>(1, 1.0f));

    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            if (i != j) {
                // Домножаем на (x - nodes[j])
                basis[i] = polynomialMultiplication(basis[i], {1.0f, -nodes[j]});
                // Нормируем множитель
                ld factor = 1.0f / (nodes[i] - nodes[j]);
                for (auto &coef : basis[i]) {
                    coef *= factor;
                }
            }
        }
        // Умножаем базисный многочлен на f(nodes[i])
        basis[i] = polynomialMultiplication(basis[i], {f(nodes[i])});
    }

    // Складываем полученные базисные многочлены
    for (int i = 0; i < N; ++i) {
        L = polynomialAddition(L, basis[i]);
    }
    return L;
}

int main() {
    cout << setprecision(9) << fixed;
    const int N = 5; // количество узлов
    const ld a = -PI, b = PI; // концы интервала
    const ld h = (b - a) / (N - 1); // шаг

    vector<ld> nodes1(N);
    for (int i = 0; i < N; ++i) {
        nodes1[i] = a + h * i;
    }

    vector<ld> nodes2(N);
    for (int i = 0; i < N; ++i) {
        nodes2[i] = 0.5f * ((b - a) * cos((2 * i + 1) * PI / (2 * N)) + (b + a));
    }

    // Построение интерполяционных полиномов
    vector<ld> L1 = LagrangePolynomial(nodes1);
    vector<ld> L2 = LagrangePolynomial(nodes2);

    cout << "Количество узлов: " << N << "\n\n";

    cout << "Полином по равноудаленным узлам:\nL1(x) = ";
    for (int i = 0; i < N - 1; ++i) {
        cout << L1[i] << "x^" << N - i - 1 << " + ";
    }
    cout << L1[N - 1] << "\n\n";

    cout << "Полином по узлам, определяемым полиномами Чебышева:\nL2(x) = ";
    for (int i = 0; i < N - 1; ++i) {
        cout << L2[i] << "x^" << N - i - 1 << " + ";
    }
    cout << L2[N - 1] << "\n\n";

    cout << "x\t\tL1(x)\t\tL2(x)\t\tf(x)\n";
    for (int i = 0; i < 10; ++i) {
        ld x = (rand() % 3001 - 1500) / 1000.0f;
        cout << x << "\t" 
             << f(x) << "\t" 
             << polynomialCalculation(L2, x) << "\t" 
             << polynomialCalculation(L1, x) << "\n";
    }
    return 0;
}