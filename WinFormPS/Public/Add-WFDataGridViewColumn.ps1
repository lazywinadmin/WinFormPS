function Add-WFDataGridViewColumn
{
<#
.SYNOPSIS
	This function add a column to a DataGridView
.DESCRIPTION
	This function add a column to a DataGridView
.EXAMPLE
	Add-WFDataGridViewColumn -DataGridView $datagridview1 -ColumnName $($textbox1.Text -split "," -replace '^\s+', '' -replace '\s+$', '')
.EXAMPLE
	Add-WFDataGridViewColumn -DataGridView $datagridview1 -ColumnName "First Name","Last Name","SamAccountName","Description"
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
		
		[String[]]$ColumnName
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		foreach ($Column in $ColumnName)
		{
			
			# Create Column object
			$NewColumn = New-Object -TypeName System.Windows.Forms.DataGridViewTextBoxColumn
			$NewColumn.Name = $Column
			$NewColumn.HeaderText = $Column
			
			# Add the Column to the Datagridview
			$DataGridView.Columns.Add($NewColumn)
		}
	}
}