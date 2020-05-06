# `wtouch`

Simulate Unix `touch` on Windows.

## Installation

Download and move [wtouch.bat](/wtouch.bat) to a valid system path.

## Usage

When the destination doesn't exist, `wtouch` will create an empty text file there:

```
> wtouch path\to\dest.txt
```

In contrary, when the destination exists, `wtouch` just view it with `dir` in the background.

## Copyright

Copyright (c) 2020 Michael Chen. Licensed under MIT.
