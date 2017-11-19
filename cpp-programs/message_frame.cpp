#include <iostream>
#include <string>

// say what stand-library names to use
using std::cin;         using std::endl;
using std::cout;        using std::string;

int main()
{
    // define inputs
    string name;
    int v_pad;
    int h_pad;

    // ask for inputs
    cout << "Please enter your first name: ";
    cin >> name;
    cout << "Vertical padding: ";
    cin >> v_pad;
    cout << "Horiztonal padding: ";
    cin >> h_pad;

    // build the message
    const string greeting = "Hello, " + name + "!";

   // total number of rows and columns to write
    const int rows = v_pad * 2 + 3;
    const string::size_type cols = greeting.size() + h_pad * 2 + 2;
    const string spaces = string(cols - 2, ' ');

    // separate the output from the input
    std::cout << std::endl;

    // write rows of output
    for (int r = 0; r != rows; ++r) {
        string::size_type c = 0;

        // invariant: written c characters so far in the current row
        while (c != cols) {
            if (r == 0 || r == rows - 1 ||
               c == 0 || c == cols - 1) {
                cout << "*";
                ++c;
            }
            else if (r == v_pad + 1) {
                if (c == h_pad + 1) {
                    cout << greeting;
                    c += greeting.size();
                } else {
                    cout << " ";
                    ++c;
                }
            } else {
                cout << spaces;
                c += spaces.size();
            } 
        }

        cout << endl;
    }

    return 0;
}
