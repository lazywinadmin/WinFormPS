function Set-WFDataGridViewFilter
{
<#
	.SYNOPSIS
		The function Set-WFDataGridViewFilter helps to only show specific entries with a specific value
	
	.DESCRIPTION
		The function Set-WFDataGridViewFilter helps to only show specific entries with a specific value.
		The data needs to be in a DataTable Object. You can use ConvertTo-DataTable to convert your
		PowerShell object into a DataTable object.
	
	.PARAMETER DataGridView
		Specifies the DataGridView control where the data will be filtered
	
	.PARAMETER DataTable
		Specifies the DataTable object that is most likely the original source of the DataGridView
	
	.PARAMETER Filter
		Specifies the string to search
	
	.PARAMETER ColumnName
		Specifies to search in a specific column name
	
	.PARAMETER AllColumns
		Specifies to search all the column
	
	.EXAMPLE
		PS C:\> Set-WFDataGridViewFilter -DataGridView $datagridview1 -DataTable $ProcessesDT -AllColumns -Filter $textbox1.Text
	
	.EXAMPLE
		PS C:\> Set-WFDataGridViewFilter -DataGridView $datagridview1 -DataTable $ProcessesDT -ColumnName "Name" -Filter $textbox1.Text
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
		
		RowFilter Help:
		https://msdn.microsoft.com/en-us/library/system.data.datacolumn.expression(VS.80).aspx
#>
	
	[CmdletBinding(DefaultParameterSetName = 'AllColumns',
				   SupportsShouldProcess = $true)]
	param
	(
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[Parameter(Mandatory = $true)]
		[System.Data.DataTable]$DataTable,
		
		[Parameter(Mandatory = $true)]
		[String]$Filter,
		
		[Parameter(ParameterSetName = 'OneColumn',
				   Mandatory = $true)]
		[String]$ColumnName,
		
		[Parameter(ParameterSetName = 'AllColumns',
				   Mandatory = $true)]
		[Switch]$AllColumns
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSBoundParameters['AllColumns'])
		{
			FOREACH ($Column in $DataTable.Columns)
			{
				$RowFilter += "{0} Like '%{1}%' OR " -f $($Column.ColumnName), $Filter
			}
			
			# Remove the last 'OR'
			$RowFilter = $RowFilter -replace " OR $", ''
		}
		IF ($PSBoundParameters['ColumnName'])
		{
			$RowFilter = "$ColumnName LIKE '%$Filter%'"
		}
		
		IF ($PSCmdlet.ShouldProcess($DataGridView, "Filter the content on $filter"))
		{
			$DataTable.defaultview.rowfilter = $RowFilter
			Import-WFDataGridViewItem -DataGridView $DataGridView -Item $DataTable
		}
	}
	END { Remove-Variable -Name $RowFilter -ErrorAction 'SilentlyContinue' | Out-Null }
}