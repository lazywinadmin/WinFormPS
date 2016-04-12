function New-WFOpenFileDialog
{
<#
	.SYNOPSIS
		The New-WFOpenFileDialog function will ask the user to select one of multiple files.
		The function will return the literal path of the file(s) selected
	
	.DESCRIPTION
		The New-WFOpenFileDialog function will ask the user to select one of multiple files.
		The function will return the literal path of the file(s) selected
	
	.PARAMETER WindowsTitle
		Specifies the Title of the window.
	
	.PARAMETER Path
		Specifies the Path where the dialog will open.
	
	.PARAMETER Filter
		Specifies the extension filter.Default is "All files (*.*)|*.*"
            Other example: 
                "Text files (*.txt)|*.txt|All files (*.*)|*.*";
                "Photos files (*.jpg)|*.png|All files (*.*)|*.*";
                        
	.PARAMETER AllowMultiSelect
		Allow the user to select multiple files.
	
	.EXAMPLE
		PS C:\> New-WFOpenFileDialog -WindowsTitle 'Upload' -Path 'c:\"
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(SupportsShouldProcess = $true)]
	param
	(
		[Parameter(Mandatory = $true)]
		[Alias('Title')]
		[String]$WindowsTitle,
		
		[Parameter(Mandatory = $true)]
		[String]$Path,
		
		[String]$Filter = "All files (*.*)|*.*",
		
		[switch]$AllowMultiSelect
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		
		# Create Object and add properties
		$OpenFileDialog = New-Object -TypeName System.Windows.Forms.OpenFileDialog
		$OpenFileDialog.InitialDirectory = $Path
		$OpenFileDialog.CheckPathExists = $true
		$OpenFileDialog.CheckFileExists = $true
		$OpenFileDialog.Title = $WindowTitle
		
		IF ($PSBoundParameters["Filter"]) { $OpenFileDialog.Filter = $Filter }
		IF ($PSBoundParameters["AllowMultiSelect"]) { $OpenFileDialog.MultiSelect = $true }
		
		IF ($PSCmdlet.ShouldProcess('OpenFileDialog','Will prompt to select a file'))
		{
			# Show the Dialog
			$OpenFileDialog.ShowHelp = $True
			[void]$OpenFileDialog.ShowDialog()
		}
	}
	END
	{
		# Return the selected file
		IF ($PSBoundParameters["AllowMultiSelect"]) { $OpenFileDialog.Filenames }
		
		# Return the selected files
		IF (-not $PSBoundParameters["AllowMultiSelect"]) { $OpenFileDialog.Filename }
	}
} #New-OpenFileDialog
