function Add-WFRichTextBoxText
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
			Add-WFRichTextBoxText -RichTextBox $RichTextBox1 -Message "Hello World"
		.EXAMPLE
			Add-WFRichTextBoxText -RichTextBox $RichTextBox1 -Message "Some info" -Source "Get-TSSession" -ComputerName "RemoteServe01"
		.NOTES
			Francois-Xavier Cat
			@lazywinadm
			www.lazywinadmin.com
			github.com/lazywinadmin
	
			VERSION HISTORY
				1.0 2014/04/16 Initial Version
				2.0 2015/02/13 Small update of parameter/Comment Based help
	#>
	[CmdletBinding()]
	PARAM (
		[Parameter(Mandatory = $true)]
		[System.Windows.Forms.Richtextbox]$RichTextBox,
		
		[Alias("ComputerName", "UserName")]
		[string]$ItemName,
		
		[Alias("ComputerNameColor", "UserNameColor")]
		[System.Drawing.Color]$ItemColor = "Blue",
		
		[Parameter(Mandatory = $true)]
		[string]$Message,
		
		[System.Drawing.Color]$MessageColor = "DarkGreen",
		
		[string]$Source,
		
		[System.Drawing.Color]$SourceColor = "Gray",
		
		[switch]$IncludeDateTime,
		
		[System.Drawing.Color]$DateTimeColor = "Black"
		
	)
	
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
			IF ($PSBoundParameters['IncludeDateTime'])
			{
				# Add the Date/Time
				$RichTextBox.SelectionColor = $DateTimeColor
				$RichTextBox.AppendText("[$SortableTime] ")
			}
			
			IF ($PSBoundParameters['ItemName'])
			{
				# Add ComputerName
				$RichTextBox.SelectionColor = $ItemColor
				$RichTextBox.AppendText(("$ItemName ").ToUpper())
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
}