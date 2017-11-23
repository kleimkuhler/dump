#include <stdexcept>
#include <vector>
#include "grade.h"
#include "median.h"

using std::domain_error;  using std::vector;

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
