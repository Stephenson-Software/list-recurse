# list recurse
The `list-recurse.sh` script is a simple bash script that lists all files in a directory and its subdirectories. It is a simple example of how to use recursion in bash to apply a script to all files in a directory and its subdirectories.

## Usage
`PROJECT_ROOT_DIR` must be set to the directory that contains `list-recurse.sh`, because the script re-invokes itself by that path each time it recurses into a subdirectory. The script exits with an error if the variable is unset.

```bash
PROJECT_ROOT_DIR="$(pwd)" ./list-recurse.sh <directory>
```

For example, from the root of this repository:

```bash
PROJECT_ROOT_DIR="$(pwd)" ./list-recurse.sh ./fruits
```