#include <algorithm>
#include <iostream>
#include <vector>

using std::cin;         using std::cout;
using std::endl;        using std::vector;
using std::sort;

typedef vector<int>::size_type vec_sz;

int main()
{
    // define vector to read integers into
    vector<int> integers;

    // append integer inputs to integers
    cout << "Please input a list of integers: ";
    int x;
    while (cin >> x)
        integers.push_back(x);

    // exit program if there are no integers
    // return integers[0] if there is one element
    vec_sz size = integers.size();
    if (size == 0) {
        cout << "Please input at least 1 integer." << endl;
        return 1;
    }
    else if (size == 1) {
        cout << "All quartiles equal. ML/M/MU = "
             << integers[0] << endl;
        return 0;
    } else {
        sort(integers.begin(), integers.end());
    }

    // define median lower/middle/upper variables
    vec_sz ML, M, MU;
    double ml, m, mu;

    int vec_mod = size % 4;
    if (vec_mod == 0) {
        // compute indicies
        M = size/2;
        ML = M/2;
        MU = M+ML;

        // computer quartiles
        ml = (integers[ML] + integers[ML-1]) / 2;
        m = (integers[M] + integers[M-1]) / 2;
        mu = (integers[MU] + integers[MU-1]) / 2;
    }
    /*
     * Trick here was just realizing how to caluclate the
     * quartiles using these 4 cases of 'modulo 4'. Just
     * additional index calculations would follow
     */
    else if (vec_mod == 1) {
        // more index calculations
    }
    else if (vec_mod == 2) {
        // more index calculations
    } else {
        // more index calculations
    }

    // print the results of ml/m/mu

    return 0;
}
