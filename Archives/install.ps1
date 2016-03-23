param([string]$InstallDirectory)

$ModuleName = "WinFormPS"
$GitHubUser = "LazyWinAdmin"
$GithubPath = "https://raw.github.com/$GitHubUser/$ModuleName/master/$ModuleName"

$fileList = Write-Output `
	"$ModuleName.psd1" `
	"$ModuleName.psm1"
    

if ('' -eq $InstallDirectory)
{
    $personalModules = Join-Path -Path ([Environment]::GetFolderPath('MyDocuments')) -ChildPath WindowsPowerShell\Modules

    if (($env:PSModulePath -split ';') -notcontains $personalModules) {
        Write-Warning "$personalModules is not in `$env:PSModulePath"
    }

    if (-not(Test-Path $personalModules)) {
        Write-Error "$personalModules does not exist"
    }

    $InstallDirectory = Join-Path -Path $personalModules -ChildPath $ModuleName
}

if (-not(Test-Path $InstallDirectory)) {
    $null = mkdir $InstallDirectory
}

$WebClient = New-Object -typename System.Net.WebClient
$fileList |
    ForEach-Object {
        $WebClient.DownloadFile("$GithubPath/$_","$installDirectory\$_")
    }
