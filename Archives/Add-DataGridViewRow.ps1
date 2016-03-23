function Add-DataGridViewRow
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		[Array]$Values
	)
	
	#foreach ($item in $Values){
	# Add a row
	$DataGridView.Rows.Add($Values)
	
}