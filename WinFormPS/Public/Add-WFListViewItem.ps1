function Add-WFListViewItem
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
		Add-WFListViewItem -ListView $listview1 -Items "Test" -Group $listview1.Groups[0] -ImageIndex 0 -SubItems "Installed"
	
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
		
		$Group,
		
		[switch]$Clear
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		
		if ($Clear)
		{
			$ListView.Items.Clear();
		}
		
		$lvGroup = $null
		if ($Group -is [System.Windows.Forms.ListViewGroup])
		{
			$lvGroup = $Group
		}
		elseif ($Group -is [string])
		{
			#$lvGroup = $ListView.Group[$Group] # Case sensitive
			foreach ($groupItem in $ListView.Groups)
			{
				if ($groupItem.Name -eq $Group)
				{
					$lvGroup = $groupItem
					break
				}
			}
			
			if (-not $lvGroup)
			{
				$lvGroup = $ListView.Groups.Add($Group, $Group)
			}
		}
		
		if ($Items -is [Array])
		{
			$ListView.BeginUpdate()
			foreach ($item in $Items)
			{
				$listitem = $ListView.Items.Add($item.ToString(), $ImageIndex)
				#Store the object in the Tag
				$listitem.Tag = $item
				
				if ($SubItems)
				{
					$listitem.SubItems.AddRange($SubItems)
				}
				
				if ($lvGroup)
				{
					$listitem.Group = $lvGroup
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
			
			if ($SubItems)
			{
				$listitem.SubItems.AddRange($SubItems)
			}
			
			if ($lvGroup)
			{
				$listitem.Group = $lvGroup
			}
		}
	} #PROCESS
}