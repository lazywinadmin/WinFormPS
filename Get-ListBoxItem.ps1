function Get-ListBoxItem
{
	<#
		.SYNOPSIS
			Function to get item(s) from a ListBox Control

		.DESCRIPTION
			Function to get item(s) from a ListBox Control

		.NOTES
			Author: Francois-Xavier Cat
			Twitter:@LazyWinAdm
			WWW: 	lazywinadmin.com
		
			VERSION HISTORY
				1.0	2014/04/15	Initial Version
	#>
	#Requires -Version 3
	PARAM (
		[ValidateNotNull()]
		[Parameter(
				   ParameterSetName = "All",
				   Mandatory)]
		[Parameter(
				   ParameterSetName = "Selected",
				   Mandatory)]
		[System.Windows.Forms.ListBox]$ListBox,
		[Parameter(
				   ParameterSetName = "All",
				   Mandatory)]
		[Parameter(
				   ParameterSetName = "Selected")]
		[switch]$ShowCount,
		
		[Parameter(
				   ParameterSetName = "Selected",
				   Mandatory)]
		[switch]$SelectedItem,
		[Parameter(
				   ParameterSetName = "All",
				   Mandatory)]
		[switch]$All
	)
	
	IF ($All)
	{
		IF ($ShowCount)
		{
			$ListBox.Items.Count
		}
		ELSE { $ListBox.Items }
	}
	
	IF ($SelectedItem)
	{
		IF ($ShowCount) { $ListBox.SelectedItems.Count }
		ELSE { $ListBox.SelectedItems }
	}
}
