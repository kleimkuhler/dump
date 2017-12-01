#include "concatenate.h"
#include "frame.h"

using std::string;  using std::vector;

vector<string> vcat(const vector<string>& top,
		    const vector<string>& bottom)
{
  // copy the top picture
  vector<string> ret = top;

  // copy entire bottom picture
  // v1
  /*
  for (vector<string>::const_iterator it = bottom.begin();
       it != bottom.end(); ++it)
    ret.push_back(*it);
  */
  // v2
  ret.insert(ret.end(), bottom.begin(), bottom.end());

  return ret;
}

vector<string> hcat(const vector<string>& left,
		    const vector<string>& right)
{
  vector<string> ret;

  // add 1 to leave space between pictures
  string::size_type width1 = width(left) + 1;

  // indices to look at elements
  vector<string>::size_type i = 0, j = 0;

  // continue until we've seen all rows from both pictures
  while (i != left.size() || j != right.size()) {
    string s;

    // copy row from left
    if (i != left.size())
      s = left[i++];

    // pad to full width
    s += string(width1 - s.size(), ' ');

    // copy row from right
    if (j != right.size())
      s += right[j++];

    ret.push_back(s);
  }
  return ret;
}
