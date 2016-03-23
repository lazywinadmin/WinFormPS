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
} #Get-ListViewItem