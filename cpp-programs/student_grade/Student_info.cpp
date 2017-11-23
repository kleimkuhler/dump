#include <iostream>
#include <stdexcept>
#include "grade.h"
#include "Student_info.h"

using std::istream;  using std::vector;
using std::cout;     using std::domain_error;

// compare the names of two students for sort()
bool compare(const Student_info& x, const Student_info& y) {
    return x.name < y.name;
}

istream& read(istream& is, Student_info& s) {
    // read and store the student's name, midterm, and final exam grades
    double midterm, final;
    is >> s.name >> midterm >> final;

    vector<double> homework;
    read_hw(is, homework);

    try {
        s.grade = grade(midterm, final, homework);
    } catch (domain_error e) {
        s.grade = -1;
    }

    return is;
}

istream& read_hw(istream& in, vector<double>& hw) {
    if (in) {
        // get rid of previous contents
        hw.clear();

        // read homework grades
        double x;
        while (in >> x)
	    hw.push_back(x);

        // clear the stream so that input will work for the next student
        in.clear();
    }          
    return in;
}
