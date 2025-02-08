# Bash bricks 🧱

![ci](https://github.com/filisko/bash-bricks/actions/workflows/main.yml/badge.svg)

Simple Bash framework that provides carefully crafted functions with good practices from the Bash and shell scripts community, and some of my own inventions.

## Installation

You can take any function you need for your project by looking at the source code, or you can...

Clone the git repo (or download the zip) wherever your scripts will be located:

```sh
git clone git@github.com:filisko/bash-bricks.git
```

Then place the following code on the top of the scripts where you would like to use the project:
```bash
#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# always boot
source "$DIR/relative-path-to-bash-bricks/boot.sh"

# load the functions you need (see that you have $BB_LIB_DIR now)
source "$BB_LIB_DIR/curl.sh"
```

(See the examples folder](https://github.com/filisko/bash-bricks/tree/master/examples)

## Contribute

Do you want to add some more carefully crafted Bash functions? Please share them!

Clone the repository:

```sh
git clone git@github.com:filisko/bash-bricks.git
```

Install shellspec automatically to run the suite of tests, or refer to [shellspec's documentation here](https://github.com/shellspec/shellspec).
```sh
curl -fsSL https://git.io/shellspec | sh -s -- --yes
```

Run the suite of tests:
```sh
shellspec
```


