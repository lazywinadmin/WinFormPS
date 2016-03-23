function Clear-WFRichTextBox
{
<#
	.SYNOPSIS
		This function will clear the content of a richtextbox control
	
	.DESCRIPTION
		A detailed description of the Clear-WFRichTextBox function.
	
	.PARAMETER RichTextBox
		A description of the RichTextBox parameter.
	
	.EXAMPLE
		Clear-WFRichTextBox -RichTextBox $RichTextBox
	
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
		[System.Windows.Forms.Richtextbox]$RichTextBox
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSCmdlet.ShouldProcess($RichTextBox, "Clear the Richtextbox control"))
		{
			#Clear the RichTextBox
			$RichTextBox.Clear()
		}
	}
}