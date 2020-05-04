# `ls`

`ls` simulates Unix `ls(1)` for Windows.

## System Requirements

Either PowerShell Core or Windows PowerShell.

## Installation

Download and move [ls.bat](/ls.bat) to a valid system path.

## Usage

Show directories and files on current working directory:

```
> ls
```

By default, it won't show the directories and the files starting with `.` (dot).

Show all text files at specific path:

```
> ls path\to\*.txt
```

Show all files at specific path:

```
> ls path\to\*.*
```

Show hidden directories and files on current working directory:

```
> ls -a
```

`ls` with `-a` parameter follows unix convention to show the directories and the files starting with `.` (dot).

## Copyright

Copyright (c) 2020 Michael Chen. Licensed under MIT.
