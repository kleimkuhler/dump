#include <algorithm>
#include <iomanip>
#include <ios>
#include <iostream>

using std::cin;         using std::cout;
using std::endl;        using std::setw;
using std::streamsize;  using std::max;

streamsize stream_width(int x)
{
  streamsize size = 0;

  // if x < 0, add 1 for '-' sign
  if (x < 0) {
    size = 1;
    x *= -1;
  }
  
  while (x != 0) {
    x /= 10;
    size++;
  }
  
  return size;
}

int main()
{
  int n, m;
  cout << "Please enter n and m: ";
  cin >> n >> m;

  // n can be negative so stream width of negative could be larger
  const streamsize col_1_width = max(stream_width(n), stream_width(m));
  const streamsize col_2_width = max(stream_width(n * n), stream_width(m * m));

  // looping [n, m] here
  for (int i = n; i != m+1; i++) {
    cout << setw(col_1_width) << i << " "
  	 << setw(col_2_width) << (i * i) << endl;
  }

  return 0;
}
