function Clear-ListBox
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.ListBox]$ListBox)
	
	#Clear the ListBox
	$ListBox.Items.Clear()
}