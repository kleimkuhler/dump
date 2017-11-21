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
using std::domain_error; using std::istream;

typedef vector<double>::size_type vec_sz;

// compute the median of a vector<double>
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

// compute a student's overall grade from midterm, final and median
// homework grade
double grade(double midterm, double final, double homework)
{
    return 0.2 * midterm + 0.4 * final + 0.4 * homework;
}

// compute a student's overall grade from midterm, final, and vector
// of homework grades
double grade(double midterm, double final, const vector<double>& hw) {
    if (hw.size() == 0) {
        throw domain_error("student has no homework");
    }
    return grade(midterm, final, median(hw));
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

    // a vector into which to read
    vector<double> homework;
    read_hw(cin, homework);

    // compute and generate the final grade
    try {
        double final_grade = grade(midterm, final, homework);
	streamsize prec = cout.precision();
	cout << "Your final grade is " << setprecision(3)
	     << final_grade << setprecision(prec) << endl;
    } catch (domain_error) {
        cout << endl << "You must enter your grades. "
	     << "Please try again." << endl;
	return 1;
    }
    return 0;
}
