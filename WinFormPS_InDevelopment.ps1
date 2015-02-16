function Get-DataGridViewItem
{
	<#
		Add Count
		Coordinate of the item (ROW index/Columnindex).value
	#>
	[CmdletBinding(DefaultParameterSetName = "CellAddress")]
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[Parameter(Mandatory = $true, ParameterSetName = "SelectedCell")]
		[Switch]$SelectedCell,
		
		[Parameter(Mandatory = $true, ParameterSetName = "SelectedRowIndex")]
		[Switch]$SelectedRowIndex,
		
		[Parameter(Mandatory = $true, ParameterSetName = "SelectedColumnIndex")]
		[Switch]$SelectedColumnIndex,
		
		[Parameter(Mandatory = $true, ParameterSetName = "SelectedRow")]
		[Switch]$SelectedRow,
		
		[Parameter(ParameterSetName = "SelectedRow")]
		[int]$ColumnNumber,
		
		[Parameter(ParameterSetName = "SelectedRow")]
		[String]$ColumnName,
		
		[Parameter(ParameterSetName = "SelectedRow")]
		[switch]$AllColumns
	)
	PROCESS
	{
		IF ($PSBoundParameters['SelectedCell'])
		{
			foreach ($SelectedCell in $datagridview1.SelectedCells)
			{
				New-Object -TypeName PSObject -Property @{
					RowIndex = $SelectedCell.RowIndex
					ColumnIndex = $SelectedCell.ColumnIndex
				}
			}
		}
		IF ($PSBoundParameters['SelectedRowIndex'])
		{
			foreach ($SelectedCell in $datagridview1.SelectedCells)
			{
				$SelectedCell.RowIndex
			}
		}
		IF ($PSBoundParameters['SelectedColumnIndex'])
		{
			foreach ($SelectedCell in $datagridview1.SelectedCells)
			{
				$SelectedCell.ColumnIndex
			}
		}
		IF ($PSBoundParameters['SelectedRow'])
		{
			
			
			#[System.Windows.Forms.DataGridViewRow]
			#foreach ($SelectedRow in
			
			if (-not ($PSboundparameters['All']))
			{
				foreach ($SelectedRow in $datagridview.SelectedRows)
				{
					IF ($PSboundparameters['ColumnNumber'])
					{
						
					}
					IF ($PSboundparameters['ColumnName'])
					{
						# Get the Selected row
						$SelectedRow.indexSelectedRows
						# Get the value for the $ColumnName of this row
						$DataGridView[$ColumnName][$d]
					}
					ELSE
					{
						$SelectedRow.value
					}
				}#foreach ($SelectedRow in $datagridview.SelectedCells)
			}#if (-not ($PSboundparameters['All'])
			if ($PSboundparameters['All'])
			{
				<#
			$SelectedRowCount = $DataGridView.Rows.GetRowCount('Selected')
			#$DisplayedRowCount = $DataGridView.Rows.GetRowCount('Displayed')
			if ($SelectedRowCount -gt 0)
			{
				IF ($PSboundparameters['ColumnNumber'])
				{
					for ([int]$i = 0, $i -gt $SelectedRowCount; $i++) { }
					$SelectedRow
					$datagridview1
					
				}
				if (-not ($PSboundparameters['ColumnNumber']) -and -not ($psboundparameter['AllColumns']))
				{
					$datagridview.SelectedRows[]
				}
			}
			#>
				
			}#if ($PSboundparameters['All'])
		}#IF ($PSBoundParameters['SelectedRow'])
	}#PROCESS
}

function Get-DataGridViewItemCount
{
<#
.SYNOPSIS
	This function will gather the count of Item
.EXAMPLE
	Disable-TabControl -TabControl $TabControl
.NOTES
	Francois-Xavier Cat
	@lazywinadm
	www.lazywinadmin.com
#>
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[Parameter(Mandatory = $true)]
		[ValidateSet("Displayed", "Frozen", "None", "ReadOnly", "Resizable", "ResizableSet", "Selected", "Visible")]
		[System.Windows.Forms.DataGridViewElementStates]$Type
	)
	PROCESS
	{
		$SelectedRowCount = $DataGridView.Rows.GetRowCount($Type)
	}
}

function Set-DataGridViewColumn
{
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[ValidateRange(1, 65535)]
		[Parameter(Mandatory = $true)]
		[int]$NumberOfColumn
	)
	$DataGridView.ColumnCount = $NumberOfColumn
}