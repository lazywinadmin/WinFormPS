function Remove-ListBoxItem
{
<#
.SYNOPSIS
	Function to remove item(s) from a ListBox Control

.DESCRIPTION
	Function to remove item(s) from a ListBox Control

.NOTES
	Author: Francois-Xavier Cat
	Twitter:@LazyWinAdm
	WWW: 	lazywinadmin.com

	VERSION HISTORY
		1.0	2014/04/15	Initial Version
#>
	
#Requires -Version 3
[CmdletBinding()]
PARAM (
	[ValidateNotNull()]
	[Parameter(ParameterSetName = "All", Mandatory)]
	[Parameter(ParameterSetName = "Pattern", Mandatory)]
	[Parameter(ParameterSetName = "Selected", Mandatory)]
	[System.Windows.Forms.ListBox]$ListBox,
	[Parameter(ParameterSetName = "All", Mandatory)]
	[Switch]$All,
	[Parameter(ParameterSetName = "Pattern", Mandatory)]
	[String[]]$Pattern,
	[Parameter(ParameterSetName = "Selected", Mandatory)]
	[Switch]$SelectedItems
)
BEGIN
{
	Write-Verbose -Message "BEGIN - ListBox - Begining to update"
	$ListBox.BeginUpdate()
}
PROCESS
{
	IF ($All)
	{
		Write-Verbose -Message "PROCESS - ListBox - Clear all item(s)"
		$ListBox.Items.Clear()
	}
	
	IF ($Pattern)
	{
		Write-Verbose -Message "PROCESS - ListBox - Clear item(s) with specific pattern"
		foreach ($item in $ListBox.Items)
		{
			foreach ($Text in $Pattern)
			{
				IF ($item -like $Text)
				{
					Write-Verbose -Message "PROCESS - ListBox - Removing item: $item"
					$ListBox.Items.Remove($item)
				}
			}
		}
	}
	IF ($SelectedItems)
	{
		while ($ListBox.SelectedItems -gt 0)
		{
			foreach ($item in $ListBox.SelectedItems)
			{
				Write-Verbose -Message "PROCESS - ListBox - Removing selected item: $item"
				$ListBox.Items.Remove($item)
			}
		}
	}
	
}
END
{
	Write-Verbose -Message "END - ListBox - End of update"
	$ListBox.EndUpdate()
}
}
