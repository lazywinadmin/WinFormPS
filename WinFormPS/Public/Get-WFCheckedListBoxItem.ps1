function Get-WFCheckedListBoxItem
{
<#
	.SYNOPSIS
		Function to get item(s) from a CheckedListBox Control
	
	.DESCRIPTION
		Function to get item(s) from a CheckedListBox Control
	
	.PARAMETER CheckedListBox
		Specifies the CheckedListBox control
	
	.PARAMETER SelectedItem
		Specifies that the function returns only the selected item (highlighted)
	
	.PARAMETER All
		Specifies that the function returns all the items
	
	.PARAMETER CheckedItem
		Specifies that the function returns only the checked items
	
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
		[Parameter(ParameterSetName = 'Checked')]
		[ValidateNotNull()]
		[System.Windows.Forms.CheckedListBox]$CheckedListBox,
		
		[Parameter(ParameterSetName = 'Selected')]
		[switch]$SelectedItem,
		
		[Parameter(ParameterSetName = 'All')]
		[switch]$All,
		
		[Parameter(ParameterSetName = 'Checked')]
		[switch]$CheckedItem
	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		
		IF ($PSBoundParameters['All'])
		{
			# Show all the items
			$CheckedListBox.Items
		}
		
		IF ($PSBoundParameters['SelectedItem'])
		{
			# Show the selected Items (highlighted)
			$CheckedListBox.SelectedItems
		}
		IF ($PSBoundParameters['CheckedItem'])
		{
			# Show the CheckedItems
			$CheckedListBox.CheckedItems
		}
	}
}