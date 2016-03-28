function Add-WFDataGridViewRow
{
<#
	.SYNOPSIS
		This function add a row to a DataGridView
	
	.DESCRIPTION
		This function add a row to a DataGridView
	
	.PARAMETER DataGridView
		Specifies the DataGridView Control to use
	
	.PARAMETER Title
		Specifies the Title to set on the new row
	
	.PARAMETER Values
		Specities the values to add
	
	.PARAMETER Collection
		Specifies the number of column to add
	
	.EXAMPLE
		Add-WFDataGridViewRow -DataGridView $datagridview1 -Title "Name1" -Values ($textbox1.Text -split ",")
	
		Add a new row with the Title 'Name1' and the values from $textbox1
		
	.EXAMPLE
		Add-WFDataGridViewRow -DataGridView $datagridview1
	
		Add an empty row
	
	.EXAMPLE
		Add-WFDataGridViewRow -DataGridView $datagridview1 -Collection 3
	
		Add 3 empty rows
	
	.EXAMPLE
		Add-WFDataGridViewRow -DataGridView $datagridview1 -Values "Francois-Xavier","Cat","fxcat"
	
		Add a row with the values specified.
	
	.NOTES
		Francois-Xavier Cat
		www.lazywinadmin.com
		@lazywinadm
		github.com/lazywinadmin
#>
	
	[CmdletBinding(DefaultParameterSetName = 'EmptyRow')]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[Parameter(ParameterSetName = 'Row',
				   Mandatory = $true)]
		[String]$Title,
		
		[Parameter(ParameterSetName = 'Row')]
		[Array]$Values,
		
		[Parameter(ParameterSetName = 'Collection',
				   Mandatory = $true)]
		[int32]$Collection
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSCmdlet.ParameterSetName -eq 'EmptyRow')
		{
			$DataGridView.Rows.Add()
		}
		ELSEIF ($PSCmdlet.ParameterSetName -eq 'Row')
		{
			$Row = New-Object -TypeName System.Windows.Forms.DataGridViewRow
			$Row.HeaderCell.Value = $Title
			$Row.CreateCells($DataGridView, $Values)
			
			# Add the row
			$DataGridView.Rows.Add($Row)
			
		}
		ELSEIF ($PSCmdlet.ParameterSetName -eq 'Collection')
		{
			$DataGridView.Rows.Add($Collection)
		}
	}
}