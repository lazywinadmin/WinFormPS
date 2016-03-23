function Add-WFDataGridViewRow
{
<#
.SYNOPSIS
	This function add a row to a DataGridView
.DESCRIPTION
	This function add a row to a DataGridView
.EXAMPLE
	Add-WFDataGridViewRow -DataGridView $datagridview1 -Values ($textbox1.Text -split ",")
.EXAMPLE
	Add-WFDataGridViewRow -DataGridView $datagridview1 -Values "Francois-Xavier","Cat","fxcat"
.NOTES
	Francois-Xavier Cat
	www.lazywinadmin.com
	@lazywinadm
	github.com/lazywinadmin
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[Array]$Values
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		# Add a row
		$DataGridView.Rows.Add($Values)
	}
} #Function Add-WFDataGridViewRow