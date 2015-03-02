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
.DESCRIPTION
	This function add a column to a DataGridView
.EXAMPLE
	Add-DataGridViewColumn -DataGridView $datagridview1 -ColumnName $($textbox1.Text -split "," -replace '^\s+', '' -replace '\s+$', '')
.EXAMPLE
	Add-DataGridViewColumn -DataGridView $datagridview1 -ColumnName "First Name","Last Name","SamAccountName","Description"
.NOTES
	Francois-Xavier Cat
	www.lazywinadmin.com
	@lazywinadm
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		[String[]]$ColumnName
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		foreach ($Column in $ColumnName)
		{
			
			# Create Column object
			$NewColumn = New-Object -TypeName System.Windows.Forms.DataGridViewTextBoxColumn
			$NewColumn.Name = $Column
			$NewColumn.HeaderText = $Column
			
			# Add the Column to the Datagridview
			$DataGridView.Columns.Add($NewColumn)
		}
	}
}#Add-DataGridViewColumn

function Add-DataGridViewRow
{
<#
.SYNOPSIS
	This function add a row to a DataGridView
.DESCRIPTION
	This function add a row to a DataGridView
.EXAMPLE
	Add-DataGridViewRow -DataGridView $datagridview1 -Values ($textbox1.Text -split ",")
.EXAMPLE
	Add-DataGridViewRow -DataGridView $datagridview1 -Values "Francois-Xavier","Cat","fxcat"
.NOTES
	Francois-Xavier Cat
	www.lazywinadmin.com
	@lazywinadm
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		[Array]$Values
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		# Add a row
		$DataGridView.Rows.Add($Values)
	}
}#Function Add-DataGridViewRow

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
			Specify the Color to use for the Message. Default is DarkGreen.
		.PARAMETER Source
			Specify the Source type of the Message
		.PARAMETER SourceColor
			Specify the Source type color to use. Default is Gray.
		.PARAMETER ItemName
			Specify a name that will help the user to identify the item
		.PARAMETER ItemColor
			Specify a color for the ItemName. Default is Blue.
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
				2.0 2015/02/13 Small update of parameter/Comment Based help
	#>
	[CmdletBinding()]
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.Richtextbox]$RichTextBox,
		
		[Parameter(Mandatory = $true)]
		[string]$Message,
		[string]$MessageColor = "DarkGreen",
		[string]$DateTimeColor = "Black",
		[string]$Source,
		[string]$SourceColor = "Gray",
		
		[Alias("ComputerName", "UserName")]
		[string]$ItemName,
		
		[Alias("ComputerNameColor", "UserNameColor")]
		[String]$ItemColor = "Blue")
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
		
		# Get current date/time. Example: 2015-12-20 18:25:03
		$SortableTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
	}
	PROCESS
	{
		TRY
		{
			# Add the Date/Time
			$RichTextBox.SelectionColor = $DateTimeColor
			$RichTextBox.AppendText("[$SortableTime] ")
			
			
			IF ($PSBoundParameters['ItemName'])
			{
				# Add ComputerName
				$RichTextBox.SelectionColor = $ItemColor
				$RichTextBox.AppendText(("$Item ").ToUpper())
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
			Write-Error -Message "PROCESS - $($Error[0].Exception.message)"
		}
	}
	END
	{
		# Refresh RichTextBox
		$RichTextBox.Refresh()
		
		# Scroll to the end of the RichTextBox
		$RichTextBox.ScrollToCaret()
	}
}#Append-Richtextbox

function Clear-DataGridViewSelection
{
<#
	.SYNOPSIS
		The Clear-DataGridViewSelection function will deselect any cell, row, column selection.
	
	.DESCRIPTION
		The Clear-DataGridViewSelection function will deselect any cell, row, column selection.
	
	.PARAMETER DataGridView
		Specifies the DataGridView Control to use.
	
	.EXAMPLE
		PS C:\> Clear-DataGridViewSelection -DataGridView $datagridviewOutput
	
	.NOTES
		Francois-Xavier Cat
		@lazywinadm
		www.lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$DataGridView.ClearSelection()
	}
}#Clear-DataGridViewSelection

function Clear-ListBox
{
<#
.SYNOPSIS
	This function will clear the content of a listbox control
.EXAMPLE
	Clear-ListBox -ListBox $ListBox
.NOTES
	Francois-Xavier Cat
	@lazywinadm
	www.lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.ListBox]$ListBox
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$ListBox.Items.Clear()
	}
}#Clear-ListBox

function Clear-RichTextBox
{
<#
.SYNOPSIS
	This function will clear the content of a richtextbox control
.EXAMPLE
	Clear-RichTextBox -RichTextBox $RichTextBox
.NOTES
	Francois-Xavier Cat
	@lazywinadm
	www.lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory)]
		[System.Windows.Forms.Richtextbox]$RichTextBox
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		#Clear the RichTextBox
		$RichTextBox.Clear()
	}
}#Clear-RichTextBox

function Disable-Button
{
<#
.SYNOPSIS
	This function will disable a button control
.EXAMPLE
	Disable-Button -Button $Button
.NOTES
	Francois-Xavier Cat
	@lazywinadm
	www.lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.Button[]]$Button
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		foreach ($ButtonObject in $Button)
		{
			$ButtonObject.Enabled = $false	
		}
		
	}
}#Disable-Button

function Disable-RichTextBox
{
<#
.SYNOPSIS
	This function will disable a RichTextBox control
.EXAMPLE
	Disable-RichTextBox -RichTextBox $RichTextBox
.NOTES
	Francois-Xavier Cat
	@lazywinadm
	www.lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.RichTextBox]$RichTextBox
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$RichTextBox.Enabled = $false
	}
}#Disable-RichTextBox

function Disable-TabControl
{
<#
.SYNOPSIS
	This function will disable a tab control
.EXAMPLE
	Disable-TabControl -TabControl $TabControl
.NOTES
	Francois-Xavier Cat
	@lazywinadm
	www.lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.TabControl]$TabControl
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$TabControl.Enabled = $false
	}
}#Disable-TabControl

function Enable-Button
{
<#
.SYNOPSIS
	This function will enable a button control
.EXAMPLE
	Enable-Button -Button $Button
.NOTES
	Francois-Xavier Cat
	@lazywinadm
	www.lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.Button[]]$Button
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		foreach ($ButtonObject in $Button)
		{
			$ButtonObject.Enabled = $true
		}
	}
}#Enable-Button

function Enable-RichTextBox
{
<#
.SYNOPSIS
	This function will enable a RichTextBox control
.EXAMPLE
	Enable-RichTextBox -RichTextBox $RichTextBox
.NOTES
	Francois-Xavier Cat
	@lazywinadm
	www.lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.RichTextBox]$RichTextBox
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$RichTextBox.Enabled = $true
	}
}#Enable-RichTextBox

function Enable-TabControl
{
<#
.SYNOPSIS
	This function will enable a tab control
.EXAMPLE
	Enable-TabControl -TabControl $TabControl
.NOTES
	Francois-Xavier Cat
	@lazywinadm
	www.lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.TabControl]$TabControl
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$TabControl.Enabled = $true
	}
}#Enable-TabControl

function Find-DataGridViewValue
{
<#
	.SYNOPSIS
		The Find-DataGridViewValue function helps you to find a specific value and select the cell, row or to set a fore and back color.
	
	.DESCRIPTION
		The Find-DataGridViewValue function helps you to find a specific value and select the cell, row or to set a fore and back color.
	
	.PARAMETER DataGridView
		Specifies the DataGridView Control to use
	
	.PARAMETER RowBackColor
		Specifies the back color of the row to use
	
	.PARAMETER RowForeColor
		Specifies the fore color of the row to use
	
	.PARAMETER SelectCell
		Specifies to select only the cell when the value is found
	
	.PARAMETER SelectRow
		Specifies to select the entire row when the value is found
	
	.PARAMETER Value
		Specifies the value to search
	
	.EXAMPLE
		PS C:\> Find-DataGridViewValue -DataGridView $datagridview1 -Value $textbox1.Text
	
		This will find the value and select the cell(s)
	
	.EXAMPLE
		PS C:\> Find-DataGridViewValue -DataGridView $datagridview1 -Value $textbox1.Text -RowForeColor 'Red' -RowBackColor 'Black'
	
		This will find the value and color the fore and back of the row
	.EXAMPLE
		PS C:\> Find-DataGridViewValue -DataGridView $datagridview1 -Value $textbox1.Text -SelectRow
	
		This will find the value and select the entire row
	
	.NOTES
		Francois-Xavier Cat
		@lazywinadm
		www.lazywinadmin.com
#>
	[CmdletBinding(DefaultParameterSetName = "Cell")]
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[Parameter(Mandatory = $true)]
		$Value,
		[Parameter(ParameterSetName = "Cell")]
		[Switch]$SelectCell,
		
		[Parameter(ParameterSetName = "Row")]
		[Switch]$SelectRow,
		
		#[Parameter(ParameterSetName = "Column")]
		#[Switch]$SelectColumn,
		
		[Parameter(ParameterSetName = "RowColor")]
		[system.Drawing.Color]$RowForeColor,
		
		[Parameter(ParameterSetName = "RowColor")]
		[system.Drawing.Color]$RowBackColor
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		FOR ([int]$i = 0; $i -lt $DataGridView.RowCount; $i++)
		{
			FOR ([int] $j = 0; $j -lt $DataGridView.ColumnCount; $j++)
			{
				$CurrentCell = $dataGridView.Rows[$i].Cells[$j]
				
				if ((-not $CurrentCell.Value.Equals([DBNull]::Value)) -and ($CurrentCell.Value.ToString() -like "*$Value*"))
				{
					# Row Selection
					IF ($PSBoundParameters['SelectRow'])
					{
						$dataGridView.Rows[$i].Selected = $true
					}
					
					<#
					# Column Selection
					IF ($PSBoundParameters['SelectColumn'])
					{
						#$DataGridView.Columns[$($CurrentCell.ColumnIndex)].Selected = $true
						#$DataGridView.Columns[$j].Selected = $true
						#$CurrentCell.DataGridView.Columns[$j].Selected = $true
					}
					#>
					
					# Row Fore Color
					IF ($PSBoundParameters['RowForeColor'])
					{
						$dataGridView.Rows[$i].DefaultCellStyle.ForeColor = $RowForeColor
					}
					# Row Back Color
					IF ($PSBoundParameters['RowBackColor'])
					{
						$dataGridView.Rows[$i].DefaultCellStyle.BackColor = $RowBackColor
					}
					
					# Cell Selection
					ELSEIF (-not ($PSBoundParameters['SelectRow']) -and -not ($PSBoundParameters['SelectColumn']))
					{
						$CurrentCell.Selected = $true
					}
				}#IF not empty and contains value
			}#For Each column
		}#For Each Row
	}#PROCESS
}#Find-DataGridViewValue

function Get-Form
{
	[CmdletBinding()]
	PARAM (
		[System.Windows.Forms.Form]$Form,
		[Switch]$Controls,
		[Switch]$TabIndex,
		[Alias('Title')]
		[Switch]$Text
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSBoundParameters["Controls"])
		{
			$Form.Controls
		}
		IF ($PSBoundParameters["TabIndex"])
		{
			$Form.TabIndex
		}
		IF ($PSBoundParameters["Text"])
		{
			$Form.Text
		}
	}#PROCESS
	
}#Set-Form

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
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(ParameterSetName = "All")]
		[Parameter(ParameterSetName = "Selected")]
		[System.Windows.Forms.ListBox]$ListBox,
		
		[Parameter(ParameterSetName = "Selected")]
		[switch]$SelectedItem,
		
		[Parameter(ParameterSetName = "All")]
		[switch]$All
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		#All
		IF ($PSBoundParameters['All'])
		{
			$ListBox.Items
		}
		
		IF ($PSBoundParameters['SelectedItem'])
		{
			$ListBox.SelectedItems
		}
	}
}#Get-ListBoxItem

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
}#Get-ListViewItem

function New-BalloonNotification
{
<#
	.SYNOPSIS
		The New-BalloonNotification function will show a message to the user in the notification area of Windows.
	
	.DESCRIPTION
		The New-BalloonNotification function will show a message to the user in the notification area of Windows.
	
	.PARAMETER BalloonIcon
		Specifies the Icon to show. Default is None
	
	.PARAMETER BalloonTipText
		Specifies the Message to show.
	
	.PARAMETER BalloonTipTitle
		Specifies the Title to show.
	
	.PARAMETER CustomIconPath
		Specifies the custom icon literal path to use. Default will use the PowerShell icon.
	
	.PARAMETER TimeOut
		Specifies the display duration of the message. Default is 10000 milliseconds
	
	.EXAMPLE
		PS C:\> New-BalloonNotification -BalloonTipText "test" -BalloonTipTitle "Title" -BalloonIcon Error
	
	.NOTES
		Francois-Xavier Cat
		@lazywinadm
		www.lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[String]$CustomIconPath = "C:\Windows\WinSxS\amd64_microsoft-windows-dxp-deviceexperience_31bf3856ad364e35_10.0.9926.0_none_220133b3b110f55a\sync.ico",
	
		[int]$TimeOut = "10000",
	
		[ValidateSet('None', 'Info', 'Warning', 'Error')]
		$BalloonIcon = "None",
		$BalloonTipText,
		$BalloonTipTitle
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
		#[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
	}
	PROCESS
	{
		
		# Create Balloon Notification object
		$BalloonNotification = New-Object -TypeName System.Windows.Forms.NotifyIcon
		
		IF ($PSBoundParameters["CustomIconPath"]) { $BalloonNotification.Icon = $CustomIconPath }
		ELSE
		{
			# Get the Icon of PowerShell
			$path = Get-Process -id $pid | Select-Object -ExpandProperty Path
			$BalloonNotification.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
		}
		
		# Set properties of the object
		$BalloonNotification.BalloonTipIcon = $BalloonIcon
		$BalloonNotification.BalloonTipText = $BalloonTipText
		$BalloonNotification.BalloonTipTitle = $BalloonTipTitle
		
		$BalloonNotification.Visible = $True
		$BalloonNotification.ShowBalloonTip($TimeOut)
	}
	END
	{
		# Get rid of the Balloon
		#$BalloonNotification.Dispose()
	}
}#New-BalloonNotification

function New-OpenFileDialog
{
<#
	.SYNOPSIS
		The New-OpenFileDialog function will ask the user to select one of multiple files.
	
	.DESCRIPTION
		The New-OpenFileDialog function will ask the user to select one of multiple files.
	
	.PARAMETER WindowsTitle
		Specifies the Title of the window.
	
	.PARAMETER Path
		Specifies the Path where the dialog will open.
	
	.PARAMETER Filter
		Specifies the extension filter.Default is "All files (*.*)|*.*"
	
	.PARAMETER AllowMultiSelect
		Allow the user to select multiple files.
	
	.EXAMPLE
		PS C:\> New-OpenFileDialog -WindowsTitle 'Upload' -Path 'c:\"
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[String]$WindowsTitle,
		
		[String]$Path = "C:\",
		
		[String]$Filter = "All files (*.*)|*.*",
		
		[switch]$AllowMultiSelect
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		
		# Create Object and add properties
		$OpenFileDialog = New-Object -TypeName System.Windows.Forms.OpenFileDialog
		$OpenFileDialog.InitialDirectory = $Path
		$OpenFileDialog.CheckPathExists = $true
		$OpenFileDialog.t
		$OpenFileDialog.Title = $WindowTitle
		$OpenFileDialog.Filter = $Filter
		
		IF ($PSBoundParameters["AllowMultiSelect"]) { $OpenFileDialog.MultiSelect = $true }
		
		# Show the Dialog
		$OpenFileDialog.ShowHelp = $True
		[void]$OpenFileDialog.ShowDialog()
		
	}
	END
	{
		# Return the selected file
		IF ($PSBoundParameters["AllowMultiSelect"]) { $OpenFileDialog.Filenames }
		
		# Return the selected files
		IF (-not $PSBoundParameters["AllowMultiSelect"]) { $OpenFileDialog.Filename }
	}
}#New-OpenFileDialog

function New-OpenFolderDialog
{
<#
	.SYNOPSIS
		The New-OpenFolderDialog function will ask the user to select one folder.
	
	.DESCRIPTION
		The New-OpenFolderDialog function will ask the user to select one folder.
	
	.PARAMETER Description
		Specifies a message to help the user select a folder
	
	.PARAMETER RootFolder
		Specifies the folder where to look. All the SpecialFolder are listed using tab. Default is "Desktop".
	
	.PARAMETER ShowNewFolderButton
		Specifies if the "New Folder" button should be displayed. Default is True.
	
	.EXAMPLE
		PS C:\> New-OpenFolderDialog -Description "Please select a folder" -RootFolder "Desktop"
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM
	(
		[Alias("Message")]
		[String]$Description = "Please select a folder",
		
		[Alias("Path")]
		[Environment+SpecialFolder]$RootFolder = "Desktop",
		
		[Alias("NewFolderButton", "NewFolder")]
		[bool]$ShowNewFolderButton = $true
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		# Create an object and properties
		$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
		$FolderBrowser.Description = $Description
		$FolderBrowser.RootFolder = $RootFolder
		$FolderBrowser.ShowNewFolderButton = $ShowNewFolderButton
		
		# Show the Dialog
		[void]$FolderBrowser.ShowDialog()
	}
	END
	{
		# Return the selected folder
		$FolderBrowser.SelectedPath
	}
}#New-OpenFolderDialog

function New-InputBox
{
<#
	.SYNOPSIS
		The New-InputBox function will prompt the user for input in a window.
	
	.DESCRIPTION
		The New-InputBox function will prompt the user for input in a window.
	
	.PARAMETER Message
		Specifies the question you want to ask to the user.
	
	.PARAMETER Title
		Specifies the title of the window.
	
	.PARAMETER DefaultInputText
		Specifies the default answer text.
	
	.EXAMPLE
		PS C:\> New-InputBox -Message 'What is your computer name' -Title 'Computer' -DefaultInputText "$env:ComputerName"
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
#>
	PARAM (
		[Parameter(Mandatory = $true)]
		[string]$Message,
		
		[Alias("WindowsTitle")]
		[string]$Title,
		
		[Alias("DefaultText")]
		[string]$DefaultInputText
		#[int32]$XPosition,
		#[int32]$YPosition
	)
	BEGIN
	{
		TRY
		{
			# Load the Assembly
			Add-Type -AssemblyName Microsoft.VisualBasic -ErrorAction 'Stop' -ErrorVariable ErrorBeginAddType
		}
		CATCH
		{
			Write-Warning -message "[BEGIN] Something wrong happened"
			IF ($ErrorBeginAddType) { Write-Warning -message "[BEGIN] Error while loading assembly Microsoft.VisualBasic" }
			Write-Error -message $Error[0].Exception.Message
		}
	}
	PROCESS
	{
		#[Microsoft.VisualBasic.Interaction]::InputBox($Message, $Title, $DefaultInputText, $XPosition, $YPosition)
		$input = [Microsoft.VisualBasic.Interaction]::InputBox($Message, $Title, $DefaultInputText)
	}
}#New-InputBox

function New-MessageBox
{
<#
	.SYNOPSIS
		The New-MessageBox functio will show a message box to the user
	
	.DESCRIPTION
		The New-MessageBox functio will show a message box to the user
	
	.PARAMETER Message
		Specifies the message to show
	
	.PARAMETER Title
		Specifies the title of the message box
	
	.PARAMETER Buttons
		Specifies which button to add. Just press tab to see the choices
	
	.PARAMETER Icon
		Specifies the icon to show. Just press tab to see the choices
	
	.EXAMPLE
		PS C:\> New-MessageBox -Message "Hello World" -Title "First Message" -Buttons "RetryCancel" -Icon "Asterix"
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		
		[String]$Message,
		[String]$Title,
		[System.Windows.Forms.MessageBoxButtons]$Buttons = "OK",
		[System.Windows.Forms.MessageBoxIcon]$Icon = "None"
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		[System.Windows.Forms.MessageBox]::Show($Message, $Title, $Buttons, $Icon)
	}
}#New-MessageBox

function New-SpeakerBeep
{
<#
	.SYNOPSIS
		The New-Beep function plays the sound of a beep of a specified frequency and duration through the console speaker.
	
	.DESCRIPTION
		The New-Beep function plays the sound of a beep of a specified frequency and duration through the console speaker.
	
	.PARAMETER Frequency
		The frequency of the beep, ranging from 37 to 32767 hertz.
	
	.PARAMETER Duration
		The duration of the beep measured in milliseconds.
	
	.EXAMPLE
		PS C:\> New-Beep -Frequency 500 -Duration 300
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[ValidateRange(37, 32767)]
		[int32]$Frequency = 800,
		[int32]$Duration = 200
	)
	PROCESS
	{
		[Console]::Beep($Frequency, $Duration)
	}
}#New-SpeakerBeep

function Refresh-DataGridView
{
	[CmdletBinding()]
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$DataGridView.Refresh()
	}
}#Refresh-DataGridView

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
		Add-Type -AssemblyName System.Windows.Forms
		
		Write-Verbose -Message "BEGIN - ListBox - Begining to update"
		$ListBox.BeginUpdate()	
	}
	PROCESS
	{
		IF ($PSBoundParameters['All'])
		{
			Write-Verbose -Message "PROCESS - ListBox - Clear all item(s)"
			
			$ListBox.Items.Clear()
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
						Write-Verbose -Message "PROCESS - ListBox - Removing item: $item"
						$ListBox.Items.Remove($item)
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
}#Remove-ListBoxItem

function Reset-DataGridViewFormat
{
<#
	.SYNOPSIS
		The Reset-DataGridViewFormat function will reset the format of a datagridview control
	
	.DESCRIPTION
		The Reset-DataGridViewFormat function will reset the format of a datagridview control
	
	.PARAMETER DataGridView
		Specifies the DataGridView Control.
	
	.EXAMPLE
		PS C:\> Reset-DataGridViewFormat -DataGridView $DataGridViewObj
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$DataSource = $DataGridView.DataSource
		$DataGridView.DataSource = $null
		$DataGridView.DataSource = $DataSource
		
		#$DataGridView.RowsDefaultCellStyle.BackColor = 'White'
		#$DataGridView.RowsDefaultCellStyle.ForeColor = 'Black'
		$DataGridView.RowsDefaultCellStyle = $null
		$DataGridView.AlternatingRowsDefaultCellStyle = $null
	}
}#Reset-DataGridViewFormat

function Set-DataGridView
{
	<#
		.SYNOPSIS
			This function helps you edit the datagridview control
	
		.DESCRIPTION
			This function helps you edit the datagridview control
	
		.EXAMPLE
			Set-DataGridView -DataGridView $datagridview1 -ProperFormat -FontFamily $listboxFontFamily.Text -FontSize $listboxFontSize.Text
	
		.EXAMPLE
			Set-DataGridView -DataGridView $datagridview1 -AlternativeRowColor -BackColor 'AliceBlue' -ForeColor 'Black'
	
		.EXAMPLE
			Set-DataGridView -DataGridView $datagridviewOutput -DefaultRowColor -BackColor 'Beige' -ForeColor 'Brown'
	
		.EXAMPLE
			Set-DataGridViewRowHeader -DataGridView $datagridview1 -HideRowHeader
	
		.EXAMPLE
			Set-DataGridViewRowHeader -DataGridView $datagridview1 -ShowRowHeader
	
		.NOTES
			Author: Francois-Xavier Cat
			Twitter:@LazyWinAdm
			WWW: 	lazywinadmin.com
	#>
	
	[CmdletBinding()]
	PARAM (
		[ValidateNotNull()]
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[Parameter(Mandatory = $true, ParameterSetName = "AlternativeRowColor")]
		[Switch]$AlternativeRowColor,
		
		[Parameter(ParameterSetName = "DefaultRowColor")]
		[Switch]$DefaultRowColor,
		
		[Parameter(Mandatory = $true, ParameterSetName = "AlternativeRowColor")]
		[Parameter(ParameterSetName = "DefaultRowColor")]
		[System.Drawing.Color]$ForeColor,
		
		[Parameter(Mandatory = $true, ParameterSetName = "AlternativeRowColor")]
		[Parameter(ParameterSetName = "DefaultRowColor")]
		[System.Drawing.Color]$BackColor,
		
		[Parameter(Mandatory = $true, ParameterSetName = "Proper")]
		[Switch]$ProperFormat,
		
		[Parameter(ParameterSetName = "Proper")]
		[String]$FontFamily = "Consolas",
		
		[Parameter(ParameterSetName = "Proper")]
		[Int]$FontSize = 10,
		
		[Parameter(ParameterSetName = "HideRowHeader")]
		[Switch]$HideRowHeader,
		[Parameter(ParameterSetName = "ShowRowHeader")]
		[Switch]$ShowRowHeader
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		if ($psboundparameters['AlternativeRowColor'])
		{
			$DataGridView.AlternatingRowsDefaultCellStyle.ForeColor = $ForeColor
			$DataGridView.AlternatingRowsDefaultCellStyle.BackColor = $BackColor
		}
		
		if ($psboundparameters['DefaultRowColor'])
		{
			$DataGridView.RowsDefaultCellStyle.ForeColor = $ForeColor
			$DataGridView.RowsDefaultCellStyle.BackColor = $BackColor
		}
		
		if ($psboundparameters['ProperFormat'])
		{
			#$Font = New-Object -TypeName System.Drawing.Font -ArgumentList "Segoi UI", 10
			$Font = New-Object -TypeName System.Drawing.Font -ArgumentList $FontFamily, $FontSize
			
			#[System.Drawing.FontStyle]::Bold
			
			$DataGridView.ColumnHeadersBorderStyle = 'Raised'
			$DataGridView.BorderStyle = 'Fixed3D'
			$DataGridView.SelectionMode = 'FullRowSelect'
			$DataGridView.AllowUserToResizeRows = $false
			$datagridview.DefaultCellStyle.font = $Font
		}
		
		if ($psboundparameters['HideRowHeader'])
		{
			$DataGridView.RowHeadersVisible = $false
		}
		if ($psboundparameters['ShowRowHeader'])
		{
			$DataGridView.RowHeadersVisible = $true
		}
	}
	
}#Set-DataGridView

function Set-DataGridViewFilter
{
<#
	.SYNOPSIS
		The function Set-DataGridViewFilter helps to only show specific entries with a specific value
	
	.DESCRIPTION
		The function Set-DataGridViewFilter helps to only show specific entries with a specific value.
		The data needs to be in a DataTable Object. You can use ConvertTo-DataTable to convert your
		PowerShell object into a DataTable object.
	
	.PARAMETER AllColumns
		Specifies to search all the column
	
	.PARAMETER ColumnName
		Specifies to search in a specific column name
	
	.PARAMETER DataGridView
		Specifies the DataGridView control where the data will be filtered
	
	.PARAMETER DataTable
		Specifies the DataTable object that is most likely the original source of the DataGridView
	
	.PARAMETER Filter
		Specifies the string to search
	
	.EXAMPLE
		PS C:\> Set-DataGridViewFilter -DataGridView $datagridview1 -DataTable $ProcessesDT -AllColumns -Filter $textbox1.Text
	
	.EXAMPLE
		PS C:\> Set-DataGridViewFilter -DataGridView $datagridview1 -DataTable $ProcessesDT -ColumnName "Name" -Filter $textbox1.Text

	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
	
		RowFilter Help:
		https://msdn.microsoft.com/en-us/library/system.data.datacolumn.expression(VS.80).aspx
#>
	[CmdletBinding()]
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.DataGridView]$DataGridView,
		[Parameter(Mandatory = $true)]
		[System.Data.DataTable]$DataTable,
		[Parameter(Mandatory = $true)]
		[String]$Filter,
		
		[Parameter(Mandatory = $true, ParameterSetName = "OneColumn")]
		[String]$ColumnName,
		[Parameter(Mandatory = $true, ParameterSetName = "AllColumns")]
		[Switch]$AllColumns
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSBoundParameters['AllColumns'])
		{
			FOREACH ($Column in $DataTable.Columns)
			{
				$RowFilter += "{0} Like '%{1}%' OR " -f $($Column.ColumnName), $Filter
			}
			
			# Remove the last 'OR'
			$RowFilter = $RowFilter -replace " OR $", ''
		}
		IF ($PSBoundParameters['ColumnName'])
		{
			$RowFilter = "$ColumnName LIKE '%$Filter%'"
		}
		
		$DataTable.defaultview.rowfilter = $RowFilter
		Load-DataGridView -DataGridView $DataGridView -Item $DataTable
	}
	END { Remove-Variable -Name $RowFilter -ErrorAction 'SilentlyContinue' | Out-Null }
}#Set-DataGridViewFilter

function Set-Form
{
<#
	.SYNOPSIS
		The Set-Form function is used to change the properties of a Form or to intract with it
	
	.DESCRIPTION
		The Set-Form function is used to change the properties of a Form or to intract with it
	
	.PARAMETER Form
		Specifies the Form control
	
	.PARAMETER Text
		Specifies the text/Title of the form
	
	.PARAMETER WindowState
		Set the Window State of the form.
	
	.PARAMETER BringToFront
		Bring the form to the front of the screen
	
	.EXAMPLE
		PS C:\> Set-Form -Form $form1 -BringToFront
	
	.EXAMPLE
		PS C:\> Set-Form -Form $form1 -Text "My GUI"
	
	.EXAMPLE
		PS C:\> Set-Form -Form $form1 -WindowState "Minimized"
	
	.NOTES
				Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
#>
	[CmdletBinding()]
	PARAM (
		[System.Windows.Forms.Form]$Form,
		[Alias('Title')]
		[String]$Text = "Hello World",
		[ValidateSet("Maximized", "Minimized", "Normal")]
		[String]$WindowState,
		[Switch]$BringToFront
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		IF ($PSBoundParameters["Text"])
		{
			$Form.Text = $Text
		}
		IF ($PSBoundParameters["WindowState"])
		{
			$Form.WindowState = $WindowState
		}
		IF ($PSBoundParameters["BringToFront"])
		{
			$Form.BringToFront()
		}
	}#PROCESS
	
}#Set-Form

function Set-RichTextBox
{
<#
	.SYNOPSIS
		The Set-RichTextBox function allow you to manage the richtextbox control
	
	.DESCRIPTION
		The Set-RichTextBox function allow you to manage the richtextbox control
	
	.PARAMETER RichTextBox
		Specifies the RichTextBox Control to use
	
	.PARAMETER ScrollToCaret
		Specifies that the RichTextBox will scroll to the end.
	
	.EXAMPLE
		PS C:\> Set-Richtextbox -PipelineVariable $value1 -RichTextBox $value2
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		WWW: 	lazywinadmin.com
#>
	
	
	[Cmdletbinding()]
	PARAM (
		[System.Windows.Forms.RichTextBox]$RichTextBox,
		[Switch]$ScrollToCaret
	)
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		$RichTextBox.ScrollToCaret()
	}
}#Set-RichTextBox


# FROM SAPIEN.com
<#.NOTES
	SAPIEN Technologies, Inc.
	http://www.sapien.com
#>

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
			
			if ($lvGroup -eq $null)
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
				
				if ($SubItems -ne $null)
				{
					$listitem.SubItems.AddRange($SubItems)
				}
				
				if ($lvGroup -ne $null)
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
			
			if ($SubItems -ne $null)
			{
				$listitem.SubItems.AddRange($SubItems)
			}
			
			if ($lvGroup -ne $null)
			{
				$listitem.Group = $lvGroup
			}
		}
	}#PROCESS
}#Add-ListViewItem

function ConvertTo-DataTable
{
	<#
		.SYNOPSIS
			Converts objects into a DataTable.
	
		.DESCRIPTION
			Converts objects into a DataTable, which are used for DataBinding.
	
		.PARAMETER  InputObject
			The input to convert into a DataTable.
	
		.PARAMETER  Table
			The DataTable you wish to load the input into.
	
		.PARAMETER RetainColumns
			This switch tells the function to keep the DataTable's existing columns.
		
		.PARAMETER FilterWMIProperties
			This switch removes WMI properties that start with an underline.
	
		.EXAMPLE
			$DataTable = ConvertTo-DataTable -InputObject (Get-Process)
	
		.NOTES
			SAPIEN Technologies, Inc.
			http://www.sapien.com/
	
			VERSION HISTORY
			1.0 ????/??/?? From Sapien.com Version
			2.0 2014/12/03 Francois-Xavier Cat - In the rows workk, I added a 
				small piece of code to handle the $null value with [DBNull]::Value
				
	#>
	[CmdletBinding()]
	[OutputType([System.Data.DataTable])]
	param (
		[ValidateNotNull()]
		$InputObject,
		[ValidateNotNull()]
		[System.Data.DataTable]$Table,
		[switch]$RetainColumns,
		[switch]$FilterWMIProperties
	)
	
	if ($Table -eq $null)
	{
		$Table = New-Object System.Data.DataTable
	}
	
	if ($InputObject -is [System.Data.DataTable])
	{
		$Table = $InputObject
	}
	else
	{
		if (-not $RetainColumns -or $Table.Columns.Count -eq 0)
		{
			#Clear out the Table Contents
			$Table.Clear()
			
			if ($InputObject -eq $null) { return } #Empty Data
			
			$object = $null
			
			#find the first non null value
			foreach ($item in $InputObject)
			{
				if ($item -ne $null)
				{
					$object = $item
					break
				}
			}
			
			if ($object -eq $null) { return } #All null then empty
			
			#COLUMN
			#Get all the properties in order to create the columns
			foreach ($prop in $object.PSObject.Get_Properties())
			{
				if (-not $FilterWMIProperties -or -not $prop.Name.StartsWith('__'))#filter out WMI properties
				{
					#Get the type from the Definition string
					$type = $null
					
					if ($prop.Value -ne $null)
					{
						try { $type = $prop.Value.GetType() }
						catch { Write-Verbose -Message "Can't find type of $prop" }
					}
					
					if ($type -ne $null) # -and [System.Type]::GetTypeCode($type) -ne 'Object')
					{
						Write-Verbose -Message "Creating Column: $($Prop.name) (Type: $type)"
						[void]$table.Columns.Add($prop.Name, $type)
					}
					else #Type info not found
					{
						#if ($prop.name -eq "" -or $prop.name -eq $null) { [void]$table.Columns.Add([DBNull]::Value) }
						[void]$table.Columns.Add($prop.Name)
					}
				}
			}
			
			if ($object -is [System.Data.DataRow])
			{
				foreach ($item in $InputObject)
				{
					$Table.Rows.Add($item)
				}
				return @(, $Table)
			}
		}
		else
		{
			$Table.Rows.Clear()
		}
		
		#Rows Work
		foreach ($item in $InputObject)
		{
			# Create a new row object
			$row = $table.NewRow()
			
			if ($item)
			{
				foreach ($prop in $item.PSObject.Get_Properties())
				{
					#Find the appropriate column to put the value
					if ($table.Columns.Contains($prop.Name))
					{
						if ($prop.value -eq $null) { $prop.value = [DBNull]::Value }
						$row.Item($prop.Name) = $prop.Value
					}
				}
			}
			[void]$table.Rows.Add($row)
		}
	}
	
	return @(, $Table)
}#ConvertTo-DataTable

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
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
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
	}
	END
	{
		$DataGridView.ResumeLayout()
	}
}#Load-DataGridView

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
	}#PROCESS
}#Load-ListBox

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
		if ($SortOrder -eq [System.Windows.Forms.SortOrder]::None)
		{
			$SortOrder = [System.Windows.Forms.SortOrder]::Ascending
		}
		
		#Set to Tag because for some reason in PowerShell ListViewItemSorter prop returns null
		$ListView.Tag = New-Object ListViewItemComparer ($ColumnIndex, $SortOrder)
		$ListView.ListViewItemSorter = $ListView.Tag #Automatically sorts
	}
}#Sort-ListViewColumn

# Export all the functions
Export-ModuleMember -Function *