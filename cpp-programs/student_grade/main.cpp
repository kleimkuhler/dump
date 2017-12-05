#include <algorithm>
#include <iomanip>
#include <ios>
#include <iostream>
#include <list>
#include <string>
#include <stdexcept>
#include <vector>
#include "extract_fails.h"
#include "grade.h"
#include "Student_info.h"

using std::cin;     using std::setprecision;
using std::cout;    using std::sort;
using std::vector;  using std::streamsize;
using std::endl;    using std::string;
using std::max;     using std::domain_error;
using std::vector;  using std::list;

typedef list<Student_info> Students_container;

int main()
{
  Students_container students;
  Student_info record;

  while(read(cin, record))
    students.push_back(record);

  // Extract failed students
  Students_container students_failed = extract_fails_final(students);

  sort(students);
  sort(students_failed);

  // Passing students
  cout << "These students passed." << endl;
  for (Students_container::const_iterator it = students.begin();
       it != students.end(); ++it)
    cout << it->name << endl;

  // Failing students
  cout << "These students failed." << endl;
  for (Students_container::const_iterator it = students_failed.begin();
       it != students_failed.end(); ++it)
    cout << it->name << endl;

  return 0;
}
