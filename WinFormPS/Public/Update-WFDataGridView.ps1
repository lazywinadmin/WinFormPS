function Update-WFDataGridView
{
<#
	.SYNOPSIS
		Function to refresh the content of a DataGridView control
	
	.DESCRIPTION
		Function to refresh the content of a DataGridView control
	
	.PARAMETER DataGridView
		Specifies the DataGridView control to update
	
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
		IF ($PSCmdlet.ShouldProcess($DataGridView,"Refresh the content"))
		{
			$DataGridView.Refresh()
		}
	}
}