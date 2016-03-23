function Enable-WFTextBox
{
<#
	.SYNOPSIS
		This function will enable a TextBox control
	
	.DESCRIPTION
		This function will enable a TextBox control
	
	.PARAMETER TextBox
		Specifies the TextBox control to enable
	
	.EXAMPLE
		Enable-WFTextBox -TextBox $TextBox
	
	.NOTES
		Francois-Xavier Cat
		@lazywinadm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[System.Windows.Forms.TextBox]$TextBox
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$TextBox.Enabled = $true
	}
}