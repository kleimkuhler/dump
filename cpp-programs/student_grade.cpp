#include <algorithm>
#include <iomanip>
#include <ios>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

using std::cin;          using std::setprecision;
using std::cout;         using std::string;
using std::endl;         using std::streamsize;
using std::vector;       using std::sort;
using std::domain_error;

typedef vector<double>::size_type vec_sz;

double grade(double midterm, double final, double homework)
{
    return 0.2 * midterm + 0.4 * final + 0.4 * homework;
}

double median(vector<double> vec)
{
    vec_sz size = vec.size();
    if (size == 0) {
        throw domain_error("median of an empty vector");
    }

    sort(vec.begin(), vec.end());

    vec_sz mid = size / 2;

    return size % 2 == 0 ? (vec[mid] + vec[mid-1]) / 2 : vec[mid];
}

int main()
{
    // ask for and read student's name
    cout << "Please enter your first name: ";
    string name;
    cin >> name;
    cout << "Hello, " << name << "!" << endl;

    // ask for and read the midterm and final grades
    cout << "Please enter your midterm and final exam grades: ";
    double midterm, final;
    cin >> midterm >> final;

    // ask for the homework grades
    cout << "Enter all your homework grades, "
            "follow by end-of-file: ";

    // the number and sum of grades read so far
    int count = 0;
    double sum = 0;

    // a vector into which to read
    vector<double> homework;

    // invariant: homework contains all the homework grades so far
    double x;
    while (cin >> x)
        homework.push_back(x);

    // write the result
    streamsize prec = cout.precision();
    cout << "Your final grade is " << setprecision(3)
	 << grade(midterm, final, median(homework))
         << setprecision(prec) << endl;

    return 0;
}
