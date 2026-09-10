# list recurse
The `list-recurse.sh` script is a simple bash script that lists the files in a directory and its subdirectories. It is a simple example of how to use recursion in bash to apply a script to the files in a directory and its subdirectories.

## Usage
`PROJECT_ROOT_DIR` must be set to the directory that contains `list-recurse.sh`, because the script re-invokes itself by that path each time it recurses into a subdirectory. The script exits with an error if the variable is unset.

```bash
PROJECT_ROOT_DIR="$(pwd)" ./list-recurse.sh <directory>
```

For example, from the root of this repository:

```bash
PROJECT_ROOT_DIR="$(pwd)" ./list-recurse.sh ./fruits
```

## Hidden entries
Entries whose names begin with a dot are not listed. The loop matches directory contents with `*`, which bash does not expand to dot-prefixed names, so hidden files and hidden directories are skipped at every level of the recursion — including `.git` when the script is pointed at a working copy.