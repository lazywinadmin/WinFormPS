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