function Disable-WFRichTextBox
{
<#
	.SYNOPSIS
		This function will disable a RichTextBox control
	
	.DESCRIPTION
		A detailed description of the Disable-WFRichTextBox function.
	
	.PARAMETER RichTextBox
		Specifies the RichTextBox control to disable
	
	.EXAMPLE
		Disable-WFRichTextBox -RichTextBox $RichTextBox
	
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
		[System.Windows.Forms.RichTextBox]$RichTextBox
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSCmdlet.ShouldProcess($RichTextBox, "Disable the RichTextBox control"))
		{
			$RichTextBox.Enabled = $false
		}
	}
}