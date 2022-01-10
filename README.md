# subst

Substitute target text with a given character.


## Installation

    make
    make install


## Usage

    subst TARG CHAR [FILE...]

- `TARG`: Directive describing characters to target.
- `CHAR`: Character to replace targets with.
- `FILE`: File from which to source text.

Should `FILE` be omitted, input is read from `stdin`.


### `TARG` Directives

- `a`, `alpha`, `alphabetic`: Target alphabetic characters.
- `n`, `num`,   `numeric`:    Target numeric characters.
- `s`, `sym`,   `symbolic`:   Target symbolic characters.
- `w`, `white`, `whitespace`: Target whitespace characters.
- `+STR`: Target characters within STR.
- `-STR`: Target characters not within STR.


## Dependencies

- CHICKEN 5


## License

Copyright (C) 2022 Robert Coffey

This is free software: you can redistribute it and/or modify it under the terms
of the GNU General Public License version 3.
