function New-WFOpenFolderDialog
{
<#
	.SYNOPSIS
		The New-WFOpenFolderDialog function will ask the user to select one folder.
	
	.DESCRIPTION
		The New-WFOpenFolderDialog function will ask the user to select one folder.
	
	.PARAMETER Description
		Specifies a message to help the user select a folder
	
	.PARAMETER RootFolder
		Specifies the folder where to look. All the SpecialFolder are listed using tab. Default is "Desktop".
	
	.PARAMETER ShowNewFolderButton
		Specifies if the "New Folder" button should be displayed. Default is True.
	
	.EXAMPLE
		PS C:\> New-WFOpenFolderDialog -Description "Please select a folder" -RootFolder "Desktop"
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(SupportsShouldProcess = $true)]
	param
	(
		[Alias('Message')]
		[String]$Description = "Please select a folder",
		
		[Alias('Path')]
		[Environment+SpecialFolder]$RootFolder = "Desktop",
		
		[Alias('NewFolderButton', 'NewFolder')]
		[bool]$ShowNewFolderButton = $true
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSCmdlet.ShouldProcess('OpenFolderDialog', 'Will prompt to select a folder'))
		{
			# Create an object and properties
			$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
			$FolderBrowser.Description = $Description
			$FolderBrowser.RootFolder = $RootFolder
			$FolderBrowser.ShowNewFolderButton = $ShowNewFolderButton
			
			# Show the Dialog
			[void]$FolderBrowser.ShowDialog()
		}
	}
	END
	{
		# Return the selected folder
		$FolderBrowser.SelectedPath
	}
} #New-OpenFolderDialog