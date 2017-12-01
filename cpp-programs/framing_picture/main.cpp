#include <iostream>
#include <string>
#include <vector>
#include "concatenate.h"
#include "frame.h"

using std::cout;    using std::cin;
using std::endl;    using std::getline;
using std::string;  using std::vector;

int main()
{
  string s;
  vector<string> picture;
  while (getline(cin, s))
    picture.push_back(s);

  cout << "Picture" << endl;
  for (vector<string>::const_iterator it = picture.begin();
       it != picture.end(); ++it)
    cout << *it << endl;

  return 0;
}
