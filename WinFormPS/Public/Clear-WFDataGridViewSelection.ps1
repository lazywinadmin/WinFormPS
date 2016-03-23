function Clear-WFDataGridViewSelection
{
<#
	.SYNOPSIS
		The Clear-WFDataGridViewSelection function will deselect any cell, row, column selection.
	
	.DESCRIPTION
		The Clear-WFDataGridViewSelection function will deselect any cell, row, column selection.
	
	.PARAMETER DataGridView
		Specifies the DataGridView Control to clear
	
	.EXAMPLE
		PS C:\> Clear-WFDataGridViewSelection -DataGridView $datagridviewOutput
	
	.NOTES
		Francois-Xavier Cat
		@lazywinadm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	[CmdletBinding()]
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$DataGridView.ClearSelection()
	}
}