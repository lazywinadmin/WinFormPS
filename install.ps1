param([string]$InstallDirectory)

$fileList = echo `
    WinFormPS.psd1 `
    WinFormPS.psm1
    

if ('' -eq $InstallDirectory)
{
    $personalModules = Join-Path -Path ([Environment]::GetFolderPath('MyDocuments')) -ChildPath WindowsPowerShell\Modules

    if (($env:PSModulePath -split ';') -notcontains $personalModules) {
        Write-Warning "$personalModules is not in `$env:PSModulePath"
    }

    if (!(Test-Path $personalModules)) {
        Write-Error "$personalModules does not exist"
    }

    $InstallDirectory = Join-Path -Path $personalModules -ChildPath WinFormPS
}

if (!(Test-Path $InstallDirectory)) {
    $null = mkdir $InstallDirectory
}

$wc = New-Object System.Net.WebClient
$fileList |
    ForEach-Object {
        $wc.DownloadFile("https://raw.github.com/LazyWinAdmin/WinFormPS/master/$_","$installDirectory\$_")
    }
