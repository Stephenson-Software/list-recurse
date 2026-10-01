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

The script also exits with status 1, printing a usage message to standard error, when no directory argument is given or when the argument is not a directory.

## Output
Each entry is printed on its own line as its name only, not its full path. Entries are listed in the order the `*` glob returns them, which is sorted by name in the current locale's collation order, and each directory's contents are listed directly beneath it, indented by two more spaces than the directory itself. Directory names are printed in bold yellow and file names in bold blue, using ANSI colour codes. After the listing the colour is reset on a final line of its own, so the output ends with a line that looks empty but contains the `\033[0m` reset sequence.

## Hidden entries
Entries whose names begin with a dot are not listed. The loop matches directory contents with `*`, which bash does not expand to dot-prefixed names, so hidden files and hidden directories are skipped at every level of the recursion — including `.git` when the script is pointed at a working copy.