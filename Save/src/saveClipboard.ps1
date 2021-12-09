# Nexss PROGRAMMER 2.x - Clipboard/Save
# Author: Marcin Polak mapoart@gmail.com

[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8
[Console]::InputEncoding = [Text.UTF8Encoding]::UTF8

$input | . "$($env:NEXSS_PACKAGES_PATH)/Nexss/Lib/NexssIn.ps1"

# add current working dir
$currentWorkingDir = (Get-Item .).FullName
$date = Get-Date (Get-Date).ToUniversalTime() -UFormat '+%Y-%m-%dT%H_%M_%S'


$prefix = "nexssp"
if ($NexssStdout._prefix) {
    $prefix = $NexssStdout._prefix
}

$filename = If ($inFieldValue_1 ) { $inFieldValue_1 } Else { "$($prefix)_$date" } 

$fileExtension = [System.IO.Path]::GetExtension($filename).Trim(".")
if ($NexssStdout._ext) {
    if ($fileExtension) {
        nxsError("--_extension cannot exist if you specified extension in the filename")
        exit 1
    }
    else {
        $fileExtension = $NexssStdout._ext
        $filename = "$($filename).$fileExtension"
    }
}

$allowedImages = @('bmp', 'gif', 'ico', 'jpg', 'jpeg', 'png', 'tif')
$filePath = ""

if ($NexssStdout._destination) {
    $filePath = $NexssStdout._destination
    if (-not (Test-Path -Path $filePath -PathType Container)) {
        nxsError("--_destination must be a folder and must exist.")
        exit 1
    }

    if (-not ($filePath -match '(\\|/)$')) {
        $filePath = "$filePath/"
    }
}

Add-Type -AssemblyName System.Windows.Forms
$clipboard = [System.Windows.Forms.Clipboard]::GetDataObject()
if ($clipboard.ContainsImage()) {
   
    if (!$fileExtension -or -not($allowedImages.contains($fileExtension))) {
        $format = [System.Drawing.Imaging.ImageFormat]::Jpeg
        $fileExtension = "jpg"
        $filename = "$filename.jpg"
        [System.Drawing.Bitmap]$clipboard.getImage().Save("$filePath$filename", $format)
    }
    else {
        switch ($fileExtension) {
            "jpg" {
                $format = [System.Drawing.Imaging.ImageFormat]::Jpeg;                 
                [System.Drawing.Bitmap]$clipboard.getImage().Save("$filePath$filename", $format)
                Break;
            }
            "ico" {
                $format = [System.Drawing.Imaging.ImageFormat]::Icon; 
                $b = [System.Drawing.Bitmap]$clipboard.getImage()
                $icon = [System.Drawing.Icon]::FromHandle($b.GetHicon()) 
                $file = New-Object System.IO.FileStream("$filePath$filename", 'OpenOrCreate')   
                $icon.Save($file) 
                $file.Close()
                $icon.Dispose()
                Break;
            }
            "tif" {
                $format = [System.Drawing.Imaging.ImageFormat]::Tiff;                 
                [System.Drawing.Bitmap]$clipboard.getImage().Save("$filePath$filename", $format)
                Break;
            }
            default {
                $format = [System.Drawing.Imaging.ImageFormat]::$fileExtension
                [System.Drawing.Bitmap]$clipboard.getImage().Save("$filePath$filename", $format)
            }
        }
    }
}
elseif ($clipboard.ContainsText()) {
    $textFromClipboard = $clipboard.getText()

    if (-not $fileExtension -or $fileExtension -eq '000Z') {
        $filename = "$filename.txt"
    }
    else {
        nxsInfo("fileextension: $fileExtension")
        if ($allowedImages.contains($fileExtension)) {
            nxsError("Your clipboard contains text but you are trying to save it as an image. Please correct a filename.")
            exit 1
        }
    }
    
    $textFromClipboard | Out-File -FilePath "$filePath$filename"
}
try {
    $NexssStdout | Add-Member -Force -NotePropertyMembers  @{nxsOut = (resolve-path "$filePath$filename").path }
}
catch {
    Write-Error 'There was an error.' -ErrorAction Stop
    exit 1
}
# STDOUT
Write-Host 	(ConvertTo-Json -Compress $NexssStdout)
