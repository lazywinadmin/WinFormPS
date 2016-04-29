# WinFormPS

WinFormPS is a PowerShell module to manage Windows Forms (WinForms) Controls.

If you are among those creating PowerShell Graphical User Interface using tools such as SAPIEN PowerShell Studio, you will realize the big need for functions to interact with the different WinForms Controls.

## Installation
#### Download from PowerShell Gallery
Coming soon...
#### Download from GitHub repository

* Download the repository
* Unblock the zip file
* Extract the folder to a module path (e.g. $home\Documents\WindowsPowerShell\Modules)


## Usage
```powershell

# Import the module.
Import-Module -Name WinFormPS

# Get the commands available
Get-Command -Module WinFormPS

# Get help
Get-Help Get-WFForm
Get-Help about_WinFormPS
```

## Examples

#### Set-WFDataGridView
This function allow you to perform different action against a DataGridView
![alt tag](https://github.com/lazywinadmin/WinFormPS/blob/master/Media/Set-WFDataGridView.gif "Set-WFDataGridView.gif")
