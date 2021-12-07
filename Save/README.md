# Clipboard/Save - Nexss PROGRAMMER 2.x

Save clipboard as text or image.

## Params

- **--\_destination="G:/5"** # default current folder
- **--\_prefix="someprefix"** # default nexssp

## Examples

Below command will save to file text, images with default filename
nexssp_2021-12-07T10_51_33 of course with the proper date:

```sh
nexss Clipboard/Save
```

Another one will check if saved file is an image, if not it will stop and show available extensions:

```sh
nexss Clipboard/Save myfilename.png
```

If clipboard data is an image it will save it as proper `ico` file:

```sh
nexss Clipboard/Save myfile.ico
```

It will store in the path of G:\myfolder\myfile_2021-12-07T10_51_33.[extension]. Extension depends on the clipboard data:

```sh
nexss Clipboard/Save --_destination="G:\myfolder" --_prefix=myfile
```
