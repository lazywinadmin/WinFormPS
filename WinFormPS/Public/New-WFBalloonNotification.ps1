function New-BalloonNotification
{
<#
	.SYNOPSIS
		The New-BalloonNotification function will show a message to the user in the notification area of Windows.
	
	.DESCRIPTION
		The New-BalloonNotification function will show a message to the user in the notification area of Windows.
	
	.PARAMETER CustomIconPath
		Specifies the custom icon literal path to use. Default will use the PowerShell icon.
	
	.PARAMETER TimeOut
		Specifies the display duration of the message. Default is 10000 milliseconds
	
	.PARAMETER BalloonIcon
		Specifies the Icon to show. Default is None
	
	.PARAMETER BalloonTipText
		Specifies the Message to show.
	
	.PARAMETER BalloonTipTitle
		Specifies the Title to show.
	
	.EXAMPLE
		PS C:\> New-BalloonNotification -BalloonTipText "test" -BalloonTipTitle "Title" -BalloonIcon Error
	
	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(SupportsShouldProcess = $true)]
	param
	(
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
		IF ($PSCmdlet.ShouldProcess("NotifyIcon","Show a new balloon notification"))
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
	}
	END
	{
		# Get rid of the Balloon
		#$BalloonNotification.Dispose()
	}
} #New-BalloonNotification