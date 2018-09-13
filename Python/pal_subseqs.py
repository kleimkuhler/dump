from itertools import chain
from itertools import combinations

def powerset(input):
    "Return the powerset (minus empty set) of `input`."
    input = list(input)
    return chain.from_iterable(combinations(input, r) 
                               for r in range(len(input), 0, -1))

def is_palindrome(s):
    "Return True if `s` equals the reverse of `s`."
    if (s == s[::-1]):
        return True
    return False

def is_disjoint(pair):
    "Return True if `pair[0]` and `pair[1]` are disjoint."
    return set(pair[0]).isdisjoint(pair[1])

def getScore(s):
    """Return the first product of two non-overlapping subsequences of the
    input. The max will be the first yielded from the filter chain because
    the powerset is computed from longest to shortest substrings."""
    subseqs = powerset(s)
    pal_subseqs = filter(is_palindrome, subseqs)
    disjoints = filter(is_disjoint, combinations(pal_subseqs, 2))
    return max(len(pair[0]) * len(pair[1]) for pair in disjoints)