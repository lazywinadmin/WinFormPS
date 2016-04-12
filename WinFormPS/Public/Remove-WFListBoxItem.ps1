function Remove-WFListBoxItem
{
<#
	.SYNOPSIS
		Function to remove item(s) from a ListBox Control
	
	.DESCRIPTION
		Function to remove item(s) from a ListBox Control
	
	.PARAMETER ListBox
		Specifies the ListBox control
	
	.PARAMETER All
		Specifies that you want to remove all the item
	
	.PARAMETER Pattern
		Specifies that you want to remove items with a specific pattern
	
	.PARAMETER SelectedItems
		Specifies that you want to remove the selected items
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(DefaultParameterSetName = 'All',
				   SupportsShouldProcess = $true)]
	param
	(
		[Parameter(ParameterSetName = 'All',
				   Mandatory = $true)]
		[Parameter(ParameterSetName = 'Pattern',
				   Mandatory = $true)]
		[Parameter(ParameterSetName = 'Selected',
				   Mandatory = $true)]
		[ValidateNotNull()]
		[System.Windows.Forms.ListBox]$ListBox,
		
		[Parameter(ParameterSetName = 'All',
				   Mandatory = $true)]
		[Switch]$All,
		
		[Parameter(ParameterSetName = 'Pattern',
				   Mandatory = $true)]
		[String[]]$Pattern,
		
		[Parameter(ParameterSetName = 'Selected',
				   Mandatory = $true)]
		[Switch]$SelectedItems
	)
	
	#Requires -Version 3
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
		
		Write-Verbose -Message "BEGIN - ListBox - Begining to update"
		$ListBox.BeginUpdate()
	}
	PROCESS
	{
		IF ($PSBoundParameters['All'])
		{
			Write-Verbose -Message "PROCESS - ListBox - Clear all item(s)"
			IF ($PSCmdlet.ShouldProcess($ListBox,"Clear all item(s)"))
			{
				$ListBox.Items.Clear()
			}
		}
		
		IF ($PSBoundParameters['Pattern'])
		{
			Write-Verbose -Message "PROCESS - ListBox - Clear item(s) with specific pattern"
			foreach ($item in $ListBox.Items)
			{
				foreach ($Text in $Pattern)
				{
					IF ($item -like $Text)
					{
						IF ($PSCmdlet.ShouldProcess($ListBox, "Remove Item with pattern $pattern : $item"))
						{
							Write-Verbose -Message "PROCESS - ListBox - Removing item: $item"
							$ListBox.Items.Remove($item)
						}
					}
				}
			}
		}
		IF ($PSBoundParameters['SelectedItems'])
		{
			while ($ListBox.SelectedItems -gt 0)
			{
				foreach ($item in $ListBox.SelectedItems)
				{
					IF ($PSCmdlet.ShouldProcess($ListBox, "Remove selected Item $item"))
					{
						Write-Verbose -Message "PROCESS - ListBox - Removing selected item: $item"
						$ListBox.Items.Remove($item)
					}
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