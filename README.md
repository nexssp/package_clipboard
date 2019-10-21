# Nexss PROGRAMMER 2.0 - Clipboard

Manage OS/System Clipboard

## Examples

```sh
nexss Clipboard # displays clipboard data
nexss Clipboard --write="This is cache long story"
nexss Clipboard --fields="cwd"
nexss Clipboard --fields="firstname,lastname"

## TODO: Clipboard multiple: see below

nexss Clipboard --push="Multiple Clipboard"
nexss Clipboard --list # displays list with unique ids
nexss Clipboard --delete uniqueId # removes item from Clipboards list

```

## This module was setup by

nexss js init
nexss js install clipboardy
