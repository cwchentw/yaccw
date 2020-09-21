# `wwhich`

Simulate Unix `which` on Windows.

## System Requirements

Use either PowerShell Core or Windows PowerShell by default. Fallback to `where` if no PowerShell on the system.

## Installation

Download and move **both** [wwhich.ps1](/wwhich.ps1) and [wwhich.bat](/wwhich.bat) to the same system path.

## Usage

Run `wwhich` with one target command:

```
> wwhich notepad
```

It works for PowerShell cmdlets as well:

```
> wwhich Get-ChildItem
```

Run `wwhich` with either `-a` or `--all` to show all possible file path(s):

```
> wwhich -a notepad
```

## Copyright

Copyright (c) 2020 Michael Chen. Licensed under MIT.

