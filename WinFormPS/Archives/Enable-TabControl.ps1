function Enable-TabControl
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.TabControl]$TabControl
	)
	$TabControl.Enabled = $true
}