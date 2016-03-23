function Add-ListViewItem
{
<#
	.SYNOPSIS
		Adds the item(s) to the ListView and stores the object in the ListViewItem's Tag property.

	.DESCRIPTION
		Adds the item(s) to the ListView and stores the object in the ListViewItem's Tag property.

	.PARAMETER ListView
		The ListView control to add the items to.

	.PARAMETER Items
		The object or objects you wish to load into the ListView's Items collection.
		
	.PARAMETER  ImageIndex
		The index of a predefined image in the ListView's ImageList.
	
	.PARAMETER  SubItems
		List of strings to add as Subitems.
	
	.PARAMETER Group
		The group to place the item(s) in.
	
	.PARAMETER Clear
		This switch clears the ListView's Items before adding the new item(s).
	
	.EXAMPLE
		Add-ListViewItem -ListView $listview1 -Items "Test" -Group $listview1.Groups[0] -ImageIndex 0 -SubItems "Installed"
	
	.EXAMPLE		
		Add-ListViewItem -ListView $listview1 -Items $Output.SamAccountName -SubItems $Output.isLockedOut, $Output.Description, $Output.DN
		
	.NOTES
		SAPIEN Technologies, Inc.
		http://www.sapien.com/
#>
	
	Param (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.ListView]$ListView,
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		$Items,
		[int]$ImageIndex = -1,
		[string[]]$SubItems,
		[System.Windows.Forms.ListViewGroup]$Group,
		[switch]$Clear)
	
	if ($Clear)
	{
		$ListView.Items.Clear();
	}
	
	if ($Items -is [Array])
	{
		$ListView.BeginUpdate()
		foreach ($item in $Items)
		{
			$listitem = $ListView.Items.Add($item.ToString(), $ImageIndex)
			#Store the object in the Tag
			$listitem.Tag = $item
			
			if ($SubItems -ne $null)
			{
				$listitem.SubItems.AddRange($SubItems)
			}
			
			if ($Group -ne $null)
			{
				$listitem.Group = $Group
			}
		}
		$ListView.EndUpdate()
	}
	else
	{
		#Add a new item to the ListView
		$listitem = $ListView.Items.Add($Items.ToString(), $ImageIndex)
		#Store the object in the Tag
		$listitem.Tag = $Items
		
		if ($SubItems -ne $null)
		{
			$listitem.SubItems.AddRange($SubItems)
		}
		
		if ($Group -ne $null)
		{
			$listitem.Group = $Group
		}
	}
}
