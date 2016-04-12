function New-WFSpeakerBeep
{
<#
	.SYNOPSIS
		The New-WFSpeakerBeep function plays the sound of a beep of a specified frequency and duration through the console speaker.
	
	.DESCRIPTION
		The New-WFSpeakerBeep function plays the sound of a beep of a specified frequency and duration through the console speaker.
	
	.PARAMETER Frequency
		The frequency of the beep, ranging from 37 to 32767 hertz.
	
	.PARAMETER Duration
		The duration of the beep measured in milliseconds.
	
	.EXAMPLE
		PS C:\> New-WFSpeakerBeep -Frequency 500 -Duration 300
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(SupportsShouldProcess = $true)]
	param
	(
		[ValidateRange(37, 32767)]
		[int32]$Frequency = 800,
		
		[int32]$Duration = 200
	)
	
	PROCESS
	{
		if ($PSCmdlet.ShouldProcess("System Console Beep", "Create a beep with a Frequency of $Frequency hertz and a duration of $Duration ms"))
		{
			[System.Console]::Beep($Frequency, $Duration)
		}
	}
}