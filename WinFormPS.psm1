##########################################################################
# Created by:   Francois-Xavier Cat
# Organization: LazyWinAdmin.com
#-------------------------------------------------------------------------
# Module Name:  WinFormPS
##########################################################################

# DataGridView
function Add-DataGridViewColumn
{
<#
.SYNOPSIS
	This function add a column to a DataGridView
#>
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		[String[]]$ColumnName
	)
	
	foreach ($Column in $ColumnName)
	{
		# Add the Column to the Datagridview
		$DataGridView.Columns.Add($Column, $Column) #ColumnName and ColumnHeader are specified
	}
}

function Add-DataGridViewRow
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		[Array]$Values
	)
	
	#foreach ($item in $Values){
	# Add a row
	$DataGridView.Rows.Add($Values)
}

function Append-Richtextbox
{
	<#
		.SYNOPSIS
			This function Append text to a RichTextBox
		.DESCRIPTION
			This function Append text to a RichTextBox
		.PARAMETER Richtextbox
			Specify the RichTextBox Control to use
		.PARAMETER Message
			Specify the Message to show
		.PARAMETER MessageColor
			Specify the Color to use for the Message
		.PARAMETER Source
			Specify the Source type of the Message
		.PARAMETER SourceColor
			Specify the Source type color to use
		.PARAMETER ComputerName
			Specify the ComputerName on which the message apply (nothing is done on a remote computer, it's just an informational parameter)
		.PARAMETER ComputerNameColor
			Specify the ComputerName color to use
		.EXAMPLE
			Append-Richtextbox -RichTextBox $RichTextBox1 -Message "Hello World"
		.EXAMPLE
			Append-Richtextbox -RichTextBox $RichTextBox1 -Message "Some info" -Source "Get-TSSession" -ComputerName "RemoteServe01"
		.NOTES
			Francois-Xavier Cat
			@lazywinadm
			www.lazywinadmin.com
	
			VERSION HISTORY
				1.0 2014/04/16 Initial Version
	#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory)]
		[System.Windows.Forms.Richtextbox]$RichTextBox,
		[Parameter(Mandatory)]
		[string]$Message,
		[string]$MessageColor = "DarkGreen",
		[string]$DateTimeColor = "Black",
		[string]$Source,
		[string]$SourceColor = "Gray",
		[string]$ComputerName,
		[String]$ComputerNameColor = "Blue")
	
	BEGIN
	{
		# Get current date/time
		$SortableTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
	}
	PROCESS
	{
		TRY
		{
			# Add the Date/Time
			$RichTextBox.SelectionColor = $DateTimeColor
			$RichTextBox.AppendText("[$SortableTime] ")
			
			
			IF ($PSBoundParameters['ComputerName'])
			{
				# Add ComputerName
				$RichTextBox.SelectionColor = $ComputerNameColor
				$RichTextBox.AppendText(("$ComputerName ").ToUpper())
			}
			
			IF ($PSBoundParameters['Source'])
			{
				# Add Source
				$RichTextBox.SelectionColor = $SourceColor
				$RichTextBox.AppendText("$Source ")
			}
			
			# Add Message with a return character
			$RichTextBox.SelectionColor = $MessageColor
			$RichTextBox.AppendText("$Message`r")
			Write-Verbose -Message "$SortableTime $Message"
		}
		CATCH
		{
			Write-Error -Message "PROCESS - Error while writing inside the RichTextBox"
		}
	}
	END
	{
		# Refresh RichTextBox
		$RichTextBox.Refresh()
		
		# Scroll to the end of the RichTextBox
		$RichTextBox.ScrollToCaret()
	}
}

function Clear-ListBox
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.ListBox]$ListBox)
	
	#Clear the ListBox
	$ListBox.Items.Clear()
}

function Clear-RichTextBox
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory)]
		[System.Windows.Forms.Richtextbox]$RichTextBox
	)
	
	#Clear the RichTextBox
	$RichTextBox.Clear()
}

function Disable-TabControl
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.TabControl]$TabControl
	)
	$TabControl.Enabled = $false
}

function Enable-TabControl
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.TabControl]$TabControl
	)
	$TabControl.Enabled = $true
}

function Get-DataGridViewItem
{
	<#
		Add Count
		Coordinate of the item (ROW index/Columnindex).value
	#>
	[CmdletBinding(DefaultParameterSetName = "CellAddress")]
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[Parameter(Mandatory = $true,ParameterSetName = "SelectedCell")]
		[Switch]$SelectedCell,
		
		[Parameter(Mandatory = $true, ParameterSetName = "SelectedRowIndex")]
		[Switch]$SelectedRowIndex,
		
		[Parameter(Mandatory = $true, ParameterSetName = "SelectedColumnIndex")]
		[Switch]$SelectedColumnIndex,
	
		[Parameter(Mandatory = $true, ParameterSetName = "SelectedRow")]
		[Switch]$SelectedRow,
		
		[Parameter(ParameterSetName = "SelectedRow")]
		[int]$ColumnNumber,
		
		[Parameter(ParameterSetName = "SelectedRow")]
		[String]$ColumnName,
		
		[Parameter(ParameterSetName = "SelectedRow")]
		[switch]$AllColumns
	)
	PROCESS
	{
		IF ($PSBoundParameters['SelectedCell'])
		{
			foreach ($SelectedCell in $datagridview1.SelectedCells)
			{
				New-Object -TypeName PSObject -Property @{
					RowIndex = $SelectedCell.RowIndex
					ColumnIndex = $SelectedCell.ColumnIndex
				}
			}
		}
		IF ($PSBoundParameters['SelectedRowIndex'])
		{
			foreach ($SelectedCell in $datagridview1.SelectedCells)
			{
				$SelectedCell.RowIndex
			}
		}
		IF ($PSBoundParameters['SelectedColumnIndex'])
		{
			foreach ($SelectedCell in $datagridview1.SelectedCells)
			{
				$SelectedCell.ColumnIndex
			}
		}
		IF ($PSBoundParameters['SelectedRow'])
		{
			
			
			#[System.Windows.Forms.DataGridViewRow]
			#foreach ($SelectedRow in
			
			if (-not ($PSboundparameters['All']))
			{
				foreach ($SelectedRow in $datagridview.SelectedRows)
				{
					IF ($PSboundparameters['ColumnNumber'])
					{
						
					}
					IF ($PSboundparameters['ColumnName'])
					{
						# Get the Selected row
						$SelectedRow.indexSelectedRows
						# Get the value for the $ColumnName of this row
						$DataGridView[$ColumnName][$d]
					}
					ELSE
					{
						$SelectedRow.value
					}
				}#foreach ($SelectedRow in $datagridview.SelectedCells)
			}#if (-not ($PSboundparameters['All'])
			if ($PSboundparameters['All'])
			{
				<#
			$SelectedRowCount = $DataGridView.Rows.GetRowCount('Selected')
			#$DisplayedRowCount = $DataGridView.Rows.GetRowCount('Displayed')
			if ($SelectedRowCount -gt 0)
			{
				IF ($PSboundparameters['ColumnNumber'])
				{
					for ([int]$i = 0, $i -gt $SelectedRowCount; $i++) { }
					$SelectedRow
					$datagridview1
					
				}
				if (-not ($PSboundparameters['ColumnNumber']) -and -not ($psboundparameter['AllColumns']))
				{
					$datagridview.SelectedRows[]
				}
			}
			#>
				
			}#if ($PSboundparameters['All'])
		}#IF ($PSBoundParameters['SelectedRow'])
	}#PROCESS
}

function Get-DataGridViewItemCount
{
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
	
		[Parameter(Mandatory = $true)]
		[ValidateSet("Displayed", "Frozen","None","ReadOnly","Resizable", "ResizableSet", "Selected", "Visible")]
		[System.Windows.Forms.DataGridViewElementStates]$Type
	)
	PROCESS
	{
		$SelectedRowCount = $DataGridView.Rows.GetRowCount($Type)
	}
}

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

function Set-DataGridViewColumn
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[ValidateRange(1, 65535)]
		[Parameter(Mandatory = $true)]
		[int]$NumberOfColumn
	)
	$DataGridView.ColumnCount = $NumberOfColumn
}

function Set-DataGridView
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[Parameter(ParameterSetName = "AlternativeRowColor")]
		[Switch]$AlternativeRowColor,
		
		[Parameter(Mandatory = $true, ParameterSetName = "AlternativeRowColor")]
		[System.Drawing.Color]$ForeColor,
		
		[Parameter(Mandatory = $true, ParameterSetName = "AlternativeRowColor")]
		[System.Drawing.Color]$BackColor,
		
		[Parameter(ParameterSetName = "Proper")]
		[Switch]$ProperFormat
	)
	PROCESS
	{
		if ($psboundparameters['AlternativeRowColor'])
		{
			$DataGridView.AlternatingRowsDefaultCellStyle.ForeColor = $ForeColor
			$DataGridView.AlternatingRowsDefaultCellStyle.BackColor = $BackColor
		}
		
		
		if ($psboundparameters['ProperFormat'])
		{
			#$Font = New-Object -TypeName System.Drawing.Font -ArgumentList "Segoi UI", 10
			$Font = New-Object -TypeName System.Drawing.Font -ArgumentList "Consolas", 10
			#[System.Drawing.FontStyle]::Bold
			
			$DataGridView.ColumnHeadersBorderStyle = 'Raised'
			$DataGridView.BorderStyle = 'Fixed3D'
			$DataGridView.SelectionMode = 'FullRowSelect'
			$DataGridView.AllowUserToResizeRows = $false
			$datagridview.DefaultCellStyle.font = $Font
		}
	}
	
}

function Set-DataGridViewRowHeader
{
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		[Switch]$HideRowHeader,
		[Switch]$ShowRowHeader
	)
	PROCESS
	{
		if ($psboundparameters['HideRowHeader'])
		{
			$DataGridView.RowHeadersVisible = $false
		}
		if ($psboundparameters['ShowRowHeader'])
		{
			$DataGridView.RowHeadersVisible = $true
		}
	}
}




# FROM SAPIEN.com
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
		
	.NOTES
		SAPIEN Technologies, Inc.
		http://www.sapien.com/
		
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

function Load-DataGridView
{
	<#
	.SYNOPSIS
		This functions helps you load items into a DataGridView.

	.DESCRIPTION
		Use this function to dynamically load items into the DataGridView control.

	.PARAMETER  DataGridView
		The ComboBox control you want to add items to.

	.PARAMETER  Item
		The object or objects you wish to load into the ComboBox's items collection.
	
	.PARAMETER  DataMember
		Sets the name of the list or table in the data source for which the DataGridView is displaying data.
	
	.NOTES
		SAPIEN Technologies, Inc.
		http://www.sapien.com/
	#>
	
	Param (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		$Item,
		[Parameter(Mandatory = $false)]
		[string]$DataMember
	)
	$DataGridView.SuspendLayout()
	$DataGridView.DataMember = $DataMember
	
	if ($Item -is [System.ComponentModel.IListSource]`
	-or $Item -is [System.ComponentModel.IBindingList] -or $Item -is [System.ComponentModel.IBindingListView])
	{
		$DataGridView.DataSource = $Item
	}
	else
	{
		$array = New-Object System.Collections.ArrayList
		
		if ($Item -is [System.Collections.IList])
		{
			$array.AddRange($Item)
		}
		else
		{
			$array.Add($Item)
		}
		$DataGridView.DataSource = $array
	}
	
	$DataGridView.ResumeLayout()
}

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


Export-ModuleMember -Function *