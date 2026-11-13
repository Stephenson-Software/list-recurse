# list recurse
The `list-recurse.sh` script is a simple bash script that lists the files in a directory and its subdirectories. It is a simple example of how to use recursion in bash to apply a script to the files in a directory and its subdirectories.

## Usage
`PROJECT_ROOT_DIR` must be set to the directory that contains `list-recurse.sh`, because the script re-invokes itself by that path each time it recurses into a subdirectory. The script exits with status 1, printing an error to standard error, if the variable is unset or empty, or if the directory it names does not contain an executable `list-recurse.sh`. It does not check that the script found there is the copy being run, so a value that points at a different copy has that copy list the subdirectories.

```bash
PROJECT_ROOT_DIR="$(pwd)" ./list-recurse.sh <directory>
```

For example, from the root of this repository:

```bash
PROJECT_ROOT_DIR="$(pwd)" ./list-recurse.sh ./fruits
```

The script also exits with status 1, printing a usage message to standard error, when no directory argument is given or when the argument is not a directory.

The script takes one argument. A second positional argument is reserved for internal use: each recursive call passes the current indentation depth in it. The script does not check a second argument given by a user, so do not pass one. A positive integer is taken as the starting depth, so every line is indented by two extra spaces per unit. Any value not equal to 0, including a non-numeric one, also skips the colour reset at the end of the listing, so the colour of the last line printed stays in effect after the script exits. A non-numeric value can also make the script print errors to standard error, for example from the final `[ $indent_level -eq 0 ]` test.

## Output
Each entry is printed on its own line as its name only, not its full path. Entries are listed in the order the `*` glob returns them, which is sorted by name in the current locale's collation order, and each directory's contents are listed directly beneath it, indented by two more spaces than the directory itself. Directory names are printed in bold yellow and file names in bold blue, using ANSI colour codes. After the listing the colour is reset on a final line of its own, so the output ends with a line that looks empty but contains the `\033[0m` reset sequence. The colour codes are written whether or not standard output is a terminal. The script does not check where its output goes, so when the output is redirected to a file or piped into another command, the escape sequences are part of the text that is written.

## Hidden entries
Entries whose names begin with a dot are not listed. The loop matches directory contents with `*`, which bash does not expand to dot-prefixed names, so hidden files and hidden directories are skipped at every level of the recursion — including `.git` when the script is pointed at a working copy.

## Symbolic links
Symbolic links to directories are followed. The loop tests each entry with `[ -d "$f" ]`, which is true for a link that points at a directory, so the link is printed as a directory and the script recurses into it. Nothing limits the depth of the recursion, so a link that points at the directory containing it, or at any directory above that, makes the script recurse until it is interrupted or a system limit stops it. Avoid running the script on a tree that contains such a link. A symbolic link to a file is printed as a file. A broken link is also printed as a file, because `[ -d ]` is false for it.

## Unreadable directories
A directory the script cannot read is not reported as an error. Its contents are matched with the `*` glob, and bash produces no matches for a directory it cannot open; because `nullglob` is set, the loop then runs zero times. The directory name is printed with nothing listed beneath it, as if the directory were empty, and the exit status is still 0. If the directory given as the argument is itself unreadable, only the final colour-reset line is printed.

A directory that has read permission but not execute (search) permission is listed differently. The glob can still read the names of its entries, so they are printed, but each `[ -d "$f" ]` test is false because the entries cannot be examined. Every entry, including any subdirectory, is therefore printed in the file colour and none is recursed into.

Both cases depend on file permissions, so a user who is not subject to them, such as root, gets the full listing.