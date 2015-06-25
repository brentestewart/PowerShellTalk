function sortPhotos([IO.DirectoryInfo]$unsortedFolder, [IO.DirectoryInfo]$root)
{      
    foreach ($file in $unsortedfolder.GetFiles())
    { 
        $fileDate = $file.LastWriteTime
            
        $oldPath = $file.FullName
        $newPath = Join-Path $root.FullName ($fileDate.ToString("yyyy")) 
        $newPath = Join-Path $newPath ($fileDate.ToString("MMM"))
        
        if (-not (Test-Path $newPath)) 
        {
            mkdir $newPath
        }

        Move-Item $oldPath $newPath
    } 
}

function resetPhotos()
{
    Copy-Item C:\pstalk\photos\backup\* C:\pstalk\photos\unsorted
    Remove-Item C:\pstalk\photos\20* -Recurse -Force
}

sortPhotos C:\pstalk\photos\unsorted C:\pstalk\photos