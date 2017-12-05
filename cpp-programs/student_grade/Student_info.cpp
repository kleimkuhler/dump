#include <iostream>
#include "Student_info.h"

using std::istream;  using std::vector;
using std::list;

// compare the names of two students for sort()
bool compare(const Student_info& x, const Student_info& y) {
    return x.name < y.name;
}

int sort(vector<Student_info>& students)
{
    sort(students.begin(), students.end(), compare);
    return 0;
}

int sort(list<Student_info>& students)
{
    students.sort(compare);
    return 0;
}

istream& read(istream& is, Student_info& s) {
    // read and store the student's name, midterm, and final exam grades
    is >> s.name >> s.midterm >> s.final;

    // read and store the student's homework grades
    read_hw(is, s.homework);

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
