# `wcd`

Do you miss Unix `cd` while using a Windows machine? `wcd` is a Windows command to satisfy your Unix nostalgia.

## Installation

Download and move [wcd.bat](/wcd.bat) to a valid system path directory.

## Usage

`wcd` is just Windows `cd` under the hood:

```
> wcd C:\Users\user\Downloads
```

When invoking `wcd` without any parameter, `wcd` will change working directory to user home directory:

```
> wcd
```

Alternatively, invoke `wcd` with `~` to change working directory to user home directory:

```
> wcd ~
```

It works for a subdirectory of home directory as well:

```
> wcd ~\Documents
```

Invoke `wcd` with either `/` or `\` to change working directory to the root path of current drive:

```
> wcd /
```

Invoke `wcd` with `-` to change working directory to last visited directory:

```
> wcd -
```

You have to keep using `wcd` istead to vanilla `cd` because `wcd` tracks your last visited directory in a text file. Use plain `cd` will lose correct visiting history recorded by `wcd`.

## Copyright

Copyright (c) 2020 Michael Chen. Licensed under MIT.
