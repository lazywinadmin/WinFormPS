function Enable-WFButton
{
<#
	.SYNOPSIS
		This function will enable a button control
	
	.DESCRIPTION
		A detailed description of the Enable-WFButton function.
	
	.PARAMETER Button
		A description of the Button parameter.
	
	.EXAMPLE
		Enable-WFButton -Button $Button
	
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
			IF ($PSCmdlet.ShouldProcess($Button, "Enable the Button Control"))
			{
				$ButtonObject.Enabled = $true
			}
		}
	}
}