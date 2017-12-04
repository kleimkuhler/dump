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
  pretty_print(picture);

  cout << "frame(Picture)" << endl;
  pretty_print(frame(picture));

  cout << "hcat(Picture, frame(Picture))" << endl;
  pretty_print(hcat(picture, frame(picture)));

  cout << "vcat(Picture, frame(Picture))" << endl;
  pretty_print(vcat(picture, frame(picture)));

  return 0;
}
