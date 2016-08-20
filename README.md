# WinFormPS

WinFormPS is a PowerShell module to manage and interact with Windows Forms (WinForms) Controls.

If you are among those creating PowerShell Graphical User Interface using tools such as SAPIEN PowerShell Studio, you will realize that you need to dive a lot into the controls and MSDN to find the accurate methods or properties to perform the actions you want.

The goal of this module is to resolve that issue and make it simpler by using a set of functions to control WinForms Controls.


## Installation
#### Download from PowerShell Gallery (PowerShell v5+)
``` powershell
Install-Module -name WinFormPS
```
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

## Help !!
Would love contributors, suggestions, feedback, and other help!

## More Information
 * Sapien's Blog - Spotlight on Controls https://www.sapien.com/blog/topics/spotlight-on-controls/
 * MSDN is a great resource if you want to find more information on the NET classes to use. See [System.Windows.Forms](https://msdn.microsoft.com/en-us/library/system.windows.forms%28v=vs.110%29.aspx?f=255&MSPPError=-2147217396)
 * [DotNetPerls.com](http://www.dotnetperls.com/windows) Great resource if you want to understand what is important in each WinForms Controls

## Notes
 * Thanks to the SAPIEN Inc. team (in particular David Corrales and June Blender) and their great tool PowerShell Studio! Really makes life easier to create, update and manage PowerShell scripts and UI. Some functions in this module are coming from SAPIEN's Team, you will notice in the Comment Based Help a mention for that. They were kind enought to let me use some their code. Thanks Again! You guys rock!

## Examples
#### Set-WFDataGridView
This function allow you to perform different action against a DataGridView
![alt tag](https://github.com/lazywinadmin/WinFormPS/blob/master/Media/Set-WFDataGridView.gif "Set-WFDataGridView.gif")