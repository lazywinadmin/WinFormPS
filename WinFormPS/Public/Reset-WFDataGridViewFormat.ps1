function Reset-WFDataGridViewFormat
{
<#
	.SYNOPSIS
		The Reset-DataGridViewFormat function will reset the format of a datagridview control
	
	.DESCRIPTION
		The Reset-DataGridViewFormat function will reset the format of a datagridview control
	
	.PARAMETER DataGridView
		Specifies the DataGridView Control.
	
	.EXAMPLE
		PS C:\> Reset-DataGridViewFormat -DataGridView $DataGridViewObj
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(SupportsShouldProcess = $true)]
	param
	(
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		if ($PSCmdlet.ShouldProcess($DataGridView, "Reset the format"))
		{
			$DataSource = $DataGridView.DataSource
			$DataGridView.DataSource = $null
			$DataGridView.DataSource = $DataSource
			
			#$DataGridView.RowsDefaultCellStyle.BackColor = 'White'
			#$DataGridView.RowsDefaultCellStyle.ForeColor = 'Black'
			$DataGridView.RowsDefaultCellStyle = $null
			$DataGridView.AlternatingRowsDefaultCellStyle = $null
		}
	}
}