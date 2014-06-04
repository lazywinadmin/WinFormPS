function Sort-ListViewColumn
{
	<#
	.SYNOPSIS
		Sort the ListView's item using the specified column.

	.DESCRIPTION
		Sort the ListView's item using the specified column.
		This function uses Add-Type to define a class that sort the items.
		The ListView's Tag property is used to keep track of the sorting.

	.PARAMETER ListView
		The ListView control to sort.

	.PARAMETER ColumnIndex
		The index of the column to use for sorting.
		
	.PARAMETER  SortOrder
		The direction to sort the items. If not specified or set to None, it will toggle.
	
	.EXAMPLE
		Sort-ListViewColumn -ListView $listview1 -ColumnIndex 0
#>
	param (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.ListView]$ListView,
		[Parameter(Mandatory = $true)]
		[int]$ColumnIndex,
		[System.Windows.Forms.SortOrder]$SortOrder = 'None')
	
	if (($ListView.Items.Count -eq 0) -or ($ColumnIndex -lt 0) -or ($ColumnIndex -ge $ListView.Columns.Count))
	{
		return;
	}
	
	#region Define ListViewItemComparer
	try
	{
		$local:type = [ListViewItemComparer]
	}
	catch
	{
		Add-Type -ReferencedAssemblies ('System.Windows.Forms') -TypeDefinition  @" 
	using System;
	using System.Windows.Forms;
	using System.Collections;
	public class ListViewItemComparer : IComparer
	{
	    public int column;
	    public SortOrder sortOrder;
	    public ListViewItemComparer()
	    {
	        column = 0;
			sortOrder = SortOrder.Ascending;
	    }
	    public ListViewItemComparer(int column, SortOrder sort)
	    {
	        this.column = column;
			sortOrder = sort;
	    }
	    public int Compare(object x, object y)
	    {
			if(column >= ((ListViewItem)x).SubItems.Count)
				return  sortOrder == SortOrder.Ascending ? -1 : 1;
		
			if(column >= ((ListViewItem)y).SubItems.Count)
				return sortOrder == SortOrder.Ascending ? 1 : -1;
		
			if(sortOrder == SortOrder.Ascending)
	        	return String.Compare(((ListViewItem)x).SubItems[column].Text, ((ListViewItem)y).SubItems[column].Text);
			else
				return String.Compare(((ListViewItem)y).SubItems[column].Text, ((ListViewItem)x).SubItems[column].Text);
	    }
	}
"@ | Out-Null
	}
	#endregion
	
	if ($ListView.Tag -is [ListViewItemComparer])
	{
		#Toggle the Sort Order
		if ($SortOrder -eq [System.Windows.Forms.SortOrder]::None)
		{
			if ($ListView.Tag.column -eq $ColumnIndex -and $ListView.Tag.sortOrder -eq 'Ascending')
			{
				$ListView.Tag.sortOrder = 'Descending'
			}
			else
			{
				$ListView.Tag.sortOrder = 'Ascending'
			}
		}
		else
		{
			$ListView.Tag.sortOrder = $SortOrder
		}
		
		$ListView.Tag.column = $ColumnIndex
		$ListView.Sort()#Sort the items
	}
	else
	{
		if ($Sort -eq [System.Windows.Forms.SortOrder]::None)
		{
			$Sort = [System.Windows.Forms.SortOrder]::Ascending
		}
		
		#Set to Tag because for some reason in PowerShell ListViewItemSorter prop returns null
		$ListView.Tag = New-Object ListViewItemComparer ($ColumnIndex, $SortOrder)
		$ListView.ListViewItemSorter = $ListView.Tag #Automatically sorts
	}
}