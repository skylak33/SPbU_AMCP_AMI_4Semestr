#include <vector>
#include <random>
#include <iostream>

using ld = long double;
using Vector = std::vector<ld>;
Vector generateRandomVector(int n) {
    Vector a(n);
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(-100, 100);
    for (int i = 0; i < n; i++) {
        a[i] = dis(gen);
    }
    return a;

}
void printVector(Vector a) {
    for (auto i : a) {
        std::cout << i << " ";
    }
    std::cout << std::endl;
}