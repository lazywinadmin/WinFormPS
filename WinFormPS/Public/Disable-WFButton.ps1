function Disable-WFButton
{
<#
	.SYNOPSIS
		This function will disable a button control
	
	.DESCRIPTION
		This function will disable a button control
	
	.PARAMETER Button
		Specifies the Button Control to disable
	
	.EXAMPLE
		Disable-WFButton -Button $Button
	
	.NOTES
		Francois-Xavier Cat
		@lazywinadm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(SupportsShouldProcess = $true)]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[System.Windows.Forms.Button[]]$Button
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		foreach ($ButtonObject in $Button)
		{
			IF ($PSCmdlet.ShouldProcess($Button, "Disable Button control"))
			{
				$ButtonObject.Enabled = $false
			}
		}
	}
}