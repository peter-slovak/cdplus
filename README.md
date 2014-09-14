cdplus
======

Extension to bash `cd` builtin that lets you quickly switch between any number of directories.

## Introduction
Ever felt like there has to be more freedom than skipping between two directories with `cd -`?  Does `pushd` and `popd` seem too restraining for its LIFO nature? Maybe `cdplus` is exactly for you.

It lets you assing index numbers to your current directories and access them later via the good old `cd`.

## Usage
Just source the cdplus.sh script:

`source cdplus.sh`

or even add the above line to your `.bashrc` or `.bash_profile` login script. Then you can make use of its functions:

* `add index_number` - Index the current directory under "index_number" 
* `list` - Show the list of indexed directories
* `flush` - Clear all indexes

After you add some indexes (or define them statically in the beginning of the file), just use `cd index_number` to change directory. If, by coincidence, there actually exists a directory with the number's name, you will cd into it. 

## Example
```
user@server:/home/user$ source cdplus.sh
user@server:/home/user$ add 0
user@server:/home/user$ cd /etc/apache2
user@server:/etc/apache2$ add 1
user@server:/etc/apache2$ list
0    /home/user
1    /etc/apache2
user@server:/etc/apache2$ cd 3
Index 3 does not exist
user@server:/etc/apache2$ cd 0
user@server:/home/user$ flush
Directory records flushed
```

## Future
* Add indexing by names
* Add workspaces
