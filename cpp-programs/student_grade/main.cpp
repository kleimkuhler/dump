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

int main_vector()
{
  vector<Student_info> students;
  Student_info record;

  while(read(cin, record))
    students.push_back(record);

  // Extract failed students
  vector<Student_info> students_failed = extract_fails_v3(students);

  sort(students.begin(), students.end(), compare);
  sort(students_failed.begin(), students_failed.end(), compare);

  // Passing students
  cout << "These students passed." << endl;
  for (vector<Student_info>::const_iterator it = students.begin();
       it != students.end(); ++it)
    cout << it->name << endl;

  // Failing students
  cout << "These students failed." << endl;
  for (vector<Student_info>::const_iterator it = students_failed.begin();
       it != students_failed.end(); ++it)
    cout << it->name << endl;

  return 0;
}

int main()
{
  list<Student_info> students;
  Student_info record;

  while(read(cin, record))
    students.push_back(record);

  // Extract failed students
  list<Student_info> students_failed = extract_fails_v4(students);

  students.sort(compare);
  students_failed.sort(compare);

  // Passing students
  cout << "These students passed." << endl;
  for (list<Student_info>::const_iterator it = students.begin();
       it != students.end(); ++it)
    cout << it->name << endl;

  // Failing students
  cout << "These students failed." << endl;
  for (list<Student_info>::const_iterator it = students_failed.begin();
       it != students_failed.end(); ++it)
    cout << it->name << endl;

  return 0;
}
