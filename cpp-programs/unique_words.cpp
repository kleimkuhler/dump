#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

using std::sort;        using std::cin;
using std::cout;        using std::endl;
using std::string;      using std::vector;

typedef vector<string>::size_type str_vec_sz;
typedef vector<int>::size_type int_vec_sz;

int main()
{
    // construct vector of words
    cout << "Please input a list of words: ";
    vector<string> words;
    string word;
    while (cin >> word)
        words.push_back(word);

    // decide whether to exit or continue
    int_vec_sz unique_words;
    str_vec_sz words_size = words.size();
    if (words_size == 0) {
        unique_words = 0;
    }
    else if (words_size == 1) {
        unique_words == 1;
    } else {
        sort(words.begin(), words.end());

        // iterate through words and increment word counts
        string prev_word;
        int words_index = 0;
        vector<int> word_counts;
        for (str_vec_sz i = 0; i != words_size; i++) {
            if (words[i].compare(prev_word) == 0) {
                word_counts[words_index-1] += 1;
            } else {
                prev_word = words[i];
                ++words_index;
                word_counts.push_back(1);
            }
        }

        // compute size of word_counts and print
        unique_words = word_counts.size();
    }

    /*
     * Originally planned to display each unique word with
     * it's count, but after understanding the gist,
     * decided to just do word_counts.size. I kept the
     * original implementation though to show the printing
     * would just be more involved.
     */
    cout << "Number of unique words = "
         << unique_words << endl;

    return 0;
}
