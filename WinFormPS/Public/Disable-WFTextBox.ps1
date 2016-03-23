function Disable-WFTextBox
{
<#
	.SYNOPSIS
		This function will disable a TextBox control
	
	.DESCRIPTION
		A detailed description of the Disable-WFTextBox function.
	
	.PARAMETER TextBox
		A description of the TextBox parameter.
	
	.EXAMPLE
		Disable-WFTextBox -TextBox $TextBox
	
	.NOTES
		Francois-Xavier Cat
		@lazywinadm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(SupportsShouldProcess = $true)]
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
		IF ($PSCmdlet.ShouldProcess($TextBox, "Disable the TextBox control"))
		{
			$TextBox.Enabled = $false
		}
	}
}