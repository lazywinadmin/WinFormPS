function Set-DataGridViewColumn
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[ValidateRange(1,65535)]	
		[Parameter(Mandatory = $true)]
		[int]$NumberOfColumn
	)
	$DataGridView.ColumnCount = $NumberOfColumn
}
