function Get-ListViewItem
{
	<#
		.SYNOPSIS
			Function to get item(s) from a ListView Control

		.DESCRIPTION
			Function to get item(s) from a ListView Control

		.NOTES
			Author: Francois-Xavier Cat
			Twitter:@LazyWinAdm
			WWW: 	lazywinadmin.com
		
			VERSION HISTORY
				1.0	2014/07/03	Initial Version
	#>
	#Requires -Version 3
	PARAM (
		[ValidateNotNull()]
		[Parameter(ParameterSetName = "All",
				   Mandatory)]
		[Parameter(ParameterSetName = "Selected",
				   Mandatory)]
		[System.Windows.Forms.ListView]$ListView,
		[Parameter(ParameterSetName = "All")]
		[Parameter(ParameterSetName = "Selected")]
		[switch]$ShowCount,
		
		[Parameter(ParameterSetName = "Selected",
				   Mandatory)]
		[switch]$SelectedItem,
		[Parameter(ParameterSetName = "All",
				   Mandatory)]
		[switch]$All
	)
	
	IF ($All)
	{
		IF ($ShowCount)
		{
			$ListView.Items.Count
		}
		ELSE { $ListView.Items }
	}
	
	IF ($SelectedItem)
	{
		IF ($ShowCount) { $ListView.SelectedItems.Count }
		ELSE { $ListView.SelectedItems }
	}
}