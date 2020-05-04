# `visit`

Do you miss Unix `cd` while using a Windows machine? `visit` is a Windows command to satisfy your Unix nostalgia.

## Installation

Download and move [visit.bat](/visit.bat) to a valid system path directory.

## Usage

`visit` is just Windows `cd` under the hood:

```
> visit C:\Users\user\Downloads
```

When invoking `visit` without any parameter, `visit` will change working directory to user home directory:

```
> visit
```

Alternatively, invoke `visit` with `~` to change working directory to user home directory:

```
> visit ~
```

Invoke `visit` with either `/` or `\` to change working directory to the root path of current drive:

```
> visit /
```

Invoke `visit` with `-` to change working directory to last visited directory:

```
> visit -
```

You have to keep using `visit` istead to vanilla `cd` because `visit` tracks your last visited directory in a text file. Use plain `cd` will lose correct visiting history recorded by `visit`.

## Copyright

Copyright (c) 2020 Michael Chen. Licensed under MIT.
