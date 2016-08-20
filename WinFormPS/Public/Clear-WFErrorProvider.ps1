function Clear-WFErrorProvider
{
<#
.SYNOPSIS
    The Clear-WFErrorProvider function will clear the error message on the Winforms control specified

.DESCRIPTION
    The Clear-WFErrorProvider function will clear the error message on the Winforms control specified

.PARAMETER ErrorProvider
    Specifies the ErrorProvider Control

.PARAMETER Control
    Specifies the Control on which the error message will be cleared

.EXAMPLE
    PS C:\> Clear-WFErrorProvider -$ErrorProvider $ErrorProvider1 -Control $TextBox1

    Clear the error message on the $TextBox1 control

.NOTES
    Francois-Xavier Cat
    @lazywinadm
    www.lazywinadmin.com
    github.com/lazywinadmin
#>

	PARAM (
		[parameter(Mandatory=$true)]
		[System.Windows.Forms.ErrorProvider]$ErrorProvider,
        [parameter(Mandatory=$true)]
		$Control
	)
    BEGIN
    {
        Add-Type -AssemblyName System.Windows.Forms
    }
    PROCESS
    {
	    $ErrorProvider.SetError($Control,'')
    }
}