#include "split.h"

using std::string;  using std::vector;
using std::isspace;

vector<string> split(const string& s)
{
  vector<string> ret;
  typedef string::size_type string_size;
  string_size i = 0;

  // invariant: we have processed characters [original value of i, i)
  while (i != s.size()) {
    while (i != s.size() && isspace(s[i]))
      ++i;

    // find end of next word
    string_size j = i;
    // invariant: none of the characters in range [original j, current j) is a space
    while (j != s.size() && !isspace(s[j]))
      ++j;

    // if nonwhitespace characters found
    if (i != j) {
      ret.push_back(s.substr(i, j-1));
      i = j;
    }
  }
  return ret;
}
