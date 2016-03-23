function Get-WFListBoxItem
{
<#
	.SYNOPSIS
		Function to get item(s) from a ListBox Control
	
	.DESCRIPTION
		Function to get item(s) from a ListBox Control
	
	.PARAMETER ListBox
		Specifies the ListBox control to get
	
	.PARAMETER SelectedItem
		Show only the selected Item
	
	.PARAMETER All
		Show all the item
	
	.EXAMPLE
		Get-WFListBoxItem -ListBox $ListBox1
	
	.EXAMPLE
		Get-WFListBoxItem -ListBox $ListBox1 -selectedItem
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(DefaultParameterSetName = 'All')]
	param
	(
		[Parameter(ParameterSetName = 'All')]
		[Parameter(ParameterSetName = 'Selected')]
		[ValidateNotNull()]
		[System.Windows.Forms.ListBox]$ListBox,
		
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
			$ListBox.Items
		}
		
		IF ($PSBoundParameters['SelectedItem'])
		{
			$ListBox.SelectedItems
		}
	}
} #Get-ListBoxItem