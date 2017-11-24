#include <iomanip>
#include <ios>
#include <iostream>
#include <stdexcept>
#include <vector>

using std::cin;           using std::cout;
using std::domain_error;  using std::endl;
using std::setprecision;  using std::streamsize;
using std::vector;

double average(const vector<double>& numbers)
{
  typedef vector<double>::size_type vec_sz;
  vec_sz size = numbers.size();
  
  if (size == 0)
    throw domain_error("no numbers provided: AVERAGE");

  double sum;
  for (vec_sz i = 0; i != size; ++i)
    sum += numbers[i];

  return sum / size;
}  

int main()
{
  cout << "Please input number: ";

  vector<double> numbers;
  double x;
  while (cin >> x)
    numbers.push_back(x);

  try {
    double avg = average(numbers);

    streamsize prec = cout.precision();
    cout << "Average: " << setprecision(3)
	 << avg << setprecision(prec);
  } catch (domain_error e) {
    cout << e.what();
  }
  cout << endl;
  
  return 0;
}
