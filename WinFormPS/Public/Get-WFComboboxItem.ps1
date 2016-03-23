function Get-WFComboboxItem
{
<#
	.SYNOPSIS
		Function to get item(s) from a Combobox Control
	
	.DESCRIPTION
		Function to get item(s) from a Combobox Control
	
	.PARAMETER ComboBox
		Specifies the Combobox control to
	
	.PARAMETER SelectedItem
		A description of the SelectedItem parameter.
	
	.PARAMETER All
		A description of the All parameter.
	
	.EXAMPLE
		Get-WFComboboxItem -ComboBox $Combobox -SelectedItem
	
	.EXAMPLE
		Get-WFComboboxItem -ComboBox $Combobox
	
	.EXAMPLE
		Get-WFComboboxItem -ComboBox $Combobox -all
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(DefaultParameterSetName = 'All')]
	param
	(
		[Parameter(ParameterSetName = 'All')]
		[Parameter(ParameterSetName = 'Selected')]
		[ValidateNotNull()]
		[System.Windows.Forms.ComboBox]$ComboBox,
		
		[Parameter(ParameterSetName = 'Selected')]
		[switch]$SelectedItem,
		
		[Parameter(ParameterSetName = 'All')]
		[switch]$All
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		#All
		IF ($PSBoundParameters['All'])
		{
			$ComboBox.Items
		}
		
		IF ($PSBoundParameters['SelectedItem'])
		{
			$ComboBox.SelectedItem
		}
	}
}