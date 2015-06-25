# Requires the following module import
# Import-Module –Name WebAdministration

Param(
  [Parameter(Mandatory=$True,Position=1)]
  [string]$rootPath
)

function updateSitePhysicalPath([string] $sitePath, [string] $physicalPath)
{
  $iisAppPath = (Join-Path 'IIS:\Sites\company\' $sitePath.replace("/", "\"))

  if ((Get-ItemProperty -Path $iisAppPath -Name physicalPath) -ne $physicalPath)
  {
    echo ("updating: " + $sitePath + " to " + $physicalPath)
    Set-ItemProperty -Path $iisAppPath -Name physicalPath -Value $physicalPath
  }
}

updateSitePhysicalPath "api" (Join-Path $rootPath "project.API")
updateSitePhysicalPath "portal" (Join-Path $rootPath "preject.Web")

$badApps = Get-ChildItem -Path IIS:\Sites\projects | Where-Object {$_.Name -like "*modules*"}
# | Where-Object {$_.PhysicalPath -notlike "$rootPath\*"}

if ($badApps.count -gt 0)
{
  foreach ($app in $badApps)
  {
    #echo ("updating module: " + $app.Name)
    $oldPath = $app.PhysicalPath

    #$newPath = [System.IO.Path]::Combine($rootPath,$oldPath.SubString($oldPath.IndexOf("\Modules") + 1))

    $iisAppPath = ('IIS:\Sites\projects' + $app.path.replace("/", "\"))

    updateSitePhysicalPath $app.path (Join-Path $rootPath $oldPath.SubString($oldPath.IndexOf("\Modules") + 1))

    #Set-ItemProperty $iisAppPath -Name physicalPath -Value (Join-Path $rootPath $oldPath.SubString($oldPath.IndexOf("\Modules") + 1))
  }

}

echo "All paths are up to date"