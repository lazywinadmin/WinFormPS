function Clear-WFListBox
{
<#
	.SYNOPSIS
		This function will clear the content of a listbox control
	
	.DESCRIPTION
		This function will clear the content of a listbox control
	
	.PARAMETER ListBox
		Specifies the ListBox control to clear
	
	.EXAMPLE
		Clear-WFListBox -ListBox $ListBox
	
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
		[System.Windows.Forms.ListBox]$ListBox
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$ListBox.Items.Clear()
	}
}