function Get-WFListViewItem
{
	<#
		.SYNOPSIS
			Function to get item(s) from a ListView Control

		.DESCRIPTION
			Function to get item(s) from a ListView Control
            
        .EXAMPLE
            Get-WFListViewItem -ListView $ListView1 -SelectedItem
            
            This will return all the selected item in the list view $listview1        

		.NOTES
			Author: Francois-Xavier Cat
			Twitter:@LazyWinAdm
			www.lazywinadmin.com
			github.com/lazywinadmin
		
			VERSION HISTORY
				1.0	2014/07/03	Initial Version
	#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(ParameterSetName = "All",
				   Mandatory)]
		[Parameter(ParameterSetName = "Selected",
				   Mandatory)]
		[System.Windows.Forms.ListView]$ListView,
		
		[Parameter(ParameterSetName = "Selected",
				   Mandatory)]
		[switch]$SelectedItem,
		
		[Parameter(ParameterSetName = "All",
				   Mandatory)]
		[switch]$All
	)
	
	IF ($PSBoundParameters['All']) { $ListView.Items }
	IF ($PSBoundParameters['SelectedItem']) { $ListView.SelectedItems }
}