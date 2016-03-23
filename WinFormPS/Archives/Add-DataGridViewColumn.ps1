function Add-DataGridViewColumn
{
	PARAM (
	[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		[String[]]$ColumnName
	)
	
	foreach ($Column in $ColumnName)
	{
		# Add the Column to the Datagridview
		$DataGridView.Columns.Add($Column, $Column) #ColumnName and ColumnHeader are specified
	}
}