function Set-WFForm
{
<#
	.SYNOPSIS
		The Set-WFForm function is used to change the properties of a Form or to intract with it
	
	.DESCRIPTION
		The Set-WFForm function is used to change the properties of a Form or to intract with it
	
	.PARAMETER Form
		Specifies the Form control
	
	.PARAMETER Text
		Specifies the text/Title of the form
	
	.PARAMETER WindowState
		Set the Window State of the form.
	
	.PARAMETER BringToFront
		Bring the form to the front of the screen
	
	.EXAMPLE
		PS C:\> Set-WFForm -Form $form1 -BringToFront
	
	.EXAMPLE
		PS C:\> Set-WFForm -Form $form1 -Text "My GUI"
	
	.EXAMPLE
		PS C:\> Set-WFForm -Form $form1 -WindowState "Minimized"
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(SupportsShouldProcess = $true)]
	param
	(
		[System.Windows.Forms.Form]$Form,
		
		[Alias('Title')]
		[String]$Text = "Hello World",
		
		[ValidateSet('Maximized', 'Minimized', 'Normal')]
		[String]$WindowState,
		
		[Switch]$BringToFront
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSBoundParameters["Text"])
		{
			IF ($PSCmdlet.ShouldProcess($Form, "Set the Title"))
			{
				$Form.Text = $Text
			}
		}
		IF ($PSBoundParameters["WindowState"])
		{
			IF ($PSCmdlet.ShouldProcess($Form, "Set Windows State to $WindowState"))
			{
				$Form.WindowState = $WindowState
			}
		}
		IF ($PSBoundParameters["BringToFront"])
		{
			IF ($PSCmdlet.ShouldProcess($Form, "Bring the Form to the front of the screen"))
			{
				$Form.BringToFront()
			}
		}
	} #PROCESS
}