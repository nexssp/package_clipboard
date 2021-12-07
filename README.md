# Nexss PROGRAMMER 2.x - Clipboard

Manage OS/System Clipboard

## Params

- **--\_destination="G:/5"** # default current folder
- **--\_prefix="someprefix"** # default nexssp

## Examples

```sh
nexss Clipboard # read clipboard data in the Clipboard field
nexss Clipboard --_write="This is cache long story" # write to cache

# For saving clipboard to file see `nexss Clipboard/Save help`
```

## TODO: Clipboard multiple: see below

### Below is not implemented yet

```sh
# TODO:
nexss Clipboard --_push="Multiple Clipboard"
nexss Clipboard --_list # displays list with unique ids
nexss Clipboard --_delete uniqueId # removes item from Clipboards list
```

## Credits

Languages/Technologies used for THIS Nexss PROGRAMMER package:

- NodeJS
- <https://github.com/sindresorhus/clipboardy>
- AutoHotKey - Another example of clipboard in the `src/` folder

## This module was setup by

```sh
nexss js init
nexss js install clipboardy
```
