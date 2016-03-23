function Enable-WFRichTextBox
{
<#
	.SYNOPSIS
		This function will enable a RichTextBox control
	
	.DESCRIPTION
		A detailed description of the Enable-WFRichTextBox function.
	
	.PARAMETER RichTextBox
		A description of the RichTextBox parameter.
	
	.EXAMPLE
		Enable-WFRichTextBox -RichTextBox $RichTextBox
	
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
		IF ($PSCmdlet.ShouldProcess($RichTextBox, "Enable the Richtextbox Control"))
		{
			$RichTextBox.Enabled = $true
		}
	}
}