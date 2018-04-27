# Shell.d
A multifile shell config that supports shell specific configs and common shell configs.  

Common shell configs are in the bash syntax.

## Shell specific configs
Each shell type will have it's own directory for it's config files.  
EX: for bash configs there is a `bash` directory.

## Common configs
Guess what, they are in the `common` directory.

### Basics
Whith the exception of `index.sh`, all files in the `shell.d` directory will be ignored for
automatic sourcing. So if you want to add a file to the `shell.d` directory, you need to explicitly
source it in `index.sh`

When `index.sh` is sourced, it will do it's best to determin the running shell and source the
appropriate directories files. If the running shell cannot be determined, the `bash` directory will
be sourced if present.

