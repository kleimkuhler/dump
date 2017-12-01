#include <iostream>
#include <string>
#include "split.h"

using std::cout;    using std::cin;
using std::endl;    using std::vector;
using std::string;  using std::getline;

int main() {
  string s;
  
  // v1
  /*
  while (getline(cin, s)) {
    vector<string> v = split(s);

    for (vector<string>::size_type i = 0; i != v.size(); ++i)
      cout << v[i] << endl;
  }
  */

  // v2
  while (cin >> s)
    cout << s << endl;
  
  return 0;
}
