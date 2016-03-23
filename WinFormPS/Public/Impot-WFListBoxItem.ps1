function Import-ListBoxItem
{
<#
	.SYNOPSIS
		This functions helps you load items into a ListBox or CheckedListBox.

	.DESCRIPTION
		Use this function to dynamically load items into the ListBox control.

	.PARAMETER  ListBox
		The ListBox control you want to add items to.

	.PARAMETER  Items
		The object or objects you wish to load into the ListBox's Items collection.

	.PARAMETER  DisplayMember
		Indicates the property to display for the items in this control.
	
	.PARAMETER  Append
		Adds the item(s) to the ListBox without clearing the Items collection.
	
	.EXAMPLE
		Import-ListBoxItem $ListBox1 "Red", "White", "Blue"
	
	.EXAMPLE
		Import-ListBoxItem $listBox1 "Red" -Append
		Import-ListBoxItem $listBox1 "White" -Append
		Import-ListBoxItem $listBox1 "Blue" -Append
	
	.EXAMPLE
		Import-ListBoxItem $listBox1 (Get-Process) "ProcessName"
		
	.NOTES
		SAPIEN Technologies, Inc.
		http://www.sapien.com/
#>
	Param (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.ListBox]$ListBox,
		
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		$Items,
		
		[Parameter(Mandatory = $false)]
		[string]$DisplayMember,
		
		[switch]$Append
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		
		if (-not $Append)
		{
			$listBox.Items.Clear()
		}
		
		if ($Items -is [System.Windows.Forms.ListBox+ObjectCollection])
		{
			$listBox.Items.AddRange($Items)
		}
		elseif ($Items -is [Array])
		{
			$listBox.BeginUpdate()
			foreach ($obj in $Items)
			{
				$listBox.Items.Add($obj)
			}
			$listBox.EndUpdate()
		}
		else
		{
			$listBox.Items.Add($Items)
		}
		
		$listBox.DisplayMember = $DisplayMember
	} #PROCESS
} #Import-ListBoxItem
#Set-Alias -Name Load-ListBox -Value Import-ListBoxItem -Description "Previous Name of this function"