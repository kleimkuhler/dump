def isValid(coordinates):
    """Create a coordinate pattern accordings to the rules outlined in the
    requirements. Compile the pattern into a regular expression object with
    the VERBOSE flag. For each coordinate, print 'Valid' if the coordinate
    matches the regex object and 'Invalid' if it does not.
    
    NOTE TO REVIEWERS: I found missing edge cases in the test inputs.
    The predefined inputs do not test for latitudes and longitudes that are
    less than 1. I added the cases for when latitude or longitude is such a
    value (e.g. (.123, .456), (.0321, .00654)) in lines 16-19 and 47-50"""
    coord_pattern = r"""
        \(      # opening left parenthesis
        [-+]?   # optional '-' or '+' sign
        (?: # latitude
            (?:
                (?: # .x - .y
                    \.  # decimal point
                    \d+ # 1 or more fractional digits
                )
                |
                (?: # 1.x - 89.x
                    (?: # integral part
                        [1-9]       # 1 - 9
                        |
                        [1-8][0-9]  # 10 - 89
                    )
                    (?: # optional decimal part
                        \.  # decimal point
                        \d+ # 1 or more fractional digits
                    )?
                )
                |
                (?: # 90.0*
                    90
                    (?: # optional decimal part
                        \.  # decimal point
                        0+ # 1 or more fractional digits
                    )?
                )
            )
        )
        ,       # comma after latitude
        \s      # space before longitude
        [-+]?   # optional '-' or '+' sign
        (?: # longitude
            (?:
                (?: # .x - .y
                    \.  # decimal point
                    \d+ # 1 or more fractional digits
                )
                |
                (?: # 1.x - 179.x
                    (?: # integral part
                        [1-9]       # 1 - 9
                        |
                        [1-9][0-9]  # 10 - 99
                        |
                        1[0-7][0-9] # 100 - 179
                    )
                    (?: # optional decimal part
                        \.  # decimal point
                        \d+ # 1 or more fractional digits
                    )?
                )
                |
                (?: # 180.0*
                    180
                    (?: # optional decimal part
                        \.  # decimal point
                        0+ # 1 or more fractional digits
                    )?
                )
            )
        )
        \)  # closing right parenthesis
        """
    rx = re.compile(coord_pattern, re.VERBOSE)
    for coord in coordinates:
        if rx.match(coord):
            print("Valid")
        else:
            print("Invalid")