function Set-WFRichTextBox
{
<#
	.SYNOPSIS
		The Set-WFRichTextBox function allow you to manage the richtextbox control
	
	.DESCRIPTION
		The Set-WFRichTextBox function allow you to manage the richtextbox control
	
	.PARAMETER RichTextBox
		Specifies the RichTextBox Control to use
	
	.PARAMETER ScrollToCaret
		Specifies that the RichTextBox will scroll to the end.
	
	.EXAMPLE
		PS C:\> Set-WFRichTextBox -PipelineVariable $value1 -RichTextBox $value2
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(SupportsShouldProcess = $true)]
	param
	(
		[System.Windows.Forms.RichTextBox]$RichTextBox,
		
		[Switch]$ScrollToCaret
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSCmdlet.ShouldProcess($RichTextBox, "Scroll to the end"))
		{
			$RichTextBox.ScrollToCaret()
		}
	}
}