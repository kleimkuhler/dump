#include <algorithm>
#include <iomanip>
#include <ios>
#include <iostream>
#include <string>
#include <stdexcept>
#include <vector>
#include "grade.h"
#include "Student_info.h"

using std::cin;     using std::setprecision;
using std::cout;    using std::sort;
using std::vector;  using std::streamsize;
using std::endl;    using std::string;
using std::max;     using std::domain_error;
using std::vector;

int main()
{
    vector<Student_info> students;
    Student_info record;
    string::size_type maxlen = 0;

    // read and store all the records
    while (read(cin, record)) {
        maxlen = max(maxlen, record.name.size());
        students.push_back(record);
    }

    // alphabetize the records
    sort(students.begin(), students.end(), compare);

    streamsize prec = cout.precision();
    for (vector<Student_info>::size_type i = 0;
        i != students.size(); ++i) {
        // write the name, padded on the right to maxlen + 1 characters
        cout << students[i].name
	     << string(maxlen + 1 - students[i].name.size(), ' ');

	// compute and write the grade
	try {
	    double final_grade = grade(students[i]);
	    streamsize prec = cout.precision();
	    cout << setprecision(3) << final_grade
		 << setprecision(prec);
	} catch (domain_error e) {
	    cout << e.what();
	}
	cout << endl;
    }
    return 0;
}
