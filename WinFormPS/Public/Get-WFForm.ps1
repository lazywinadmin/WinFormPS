function Get-WFForm
{
<#
	.SYNOPSIS
		Function to retrieve information about the a Form
	
	.DESCRIPTION
		Function to retrieve information about the a Form
	
	.PARAMETER Form
		Specifies the Form
	
	.PARAMETER Controls
		Specifies that you want to see all the controls in the form
	
	.PARAMETER TabIndex
		Specifies that you want to see the tab index
	
	.PARAMETER Text
		Specifies that you want to see the Title of the form
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding()]
	param
	(
		[System.Windows.Forms.Form]$Form,
		
		[Switch]$Controls,
		
		[Switch]$TabIndex,
		
		[Alias('Title')]
		[Switch]$Text
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSBoundParameters["Controls"])
		{
			$Form.Controls
		}
		IF ($PSBoundParameters["TabIndex"])
		{
			$Form.TabIndex
		}
		IF ($PSBoundParameters["Text"])
		{
			$Form.Text
		}
	} #PROCESS
}