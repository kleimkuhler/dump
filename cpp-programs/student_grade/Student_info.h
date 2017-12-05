#ifndef GUARD_Student_info_h
#define GUARD_Student_info_h

#include <iostream>
#include <list>
#include <string>
#include <vector>

struct Student_info {
    std::string name;
    double midterm, final;
    std::vector<double> homework;
};

bool compare(const Student_info&, const Student_info&);
int sort(std::vector<Student_info>&);
int sort(std::list<Student_info>&);
std::istream& read(std::istream&, Student_info&);
std::istream& read_hw(std::istream&, std::vector<double>&);

#endif
