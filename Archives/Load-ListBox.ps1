function Load-ListBox
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
		Load-ListBox $ListBox1 "Red", "White", "Blue"
	
	.EXAMPLE
		Load-ListBox $listBox1 "Red" -Append
		Load-ListBox $listBox1 "White" -Append
		Load-ListBox $listBox1 "Blue" -Append
	
	.EXAMPLE
		Load-ListBox $listBox1 (Get-Process) "ProcessName"
		
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
}
