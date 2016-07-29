function Set-WFDataGridView
{
<#
	.SYNOPSIS
		This function helps you edit the datagridview control
	
	.DESCRIPTION
		This function helps you edit the datagridview control
	
	.PARAMETER DataGridView
		Specifies the DataGridView Control
	
	.PARAMETER AlternativeRowColor
		Specifies the color of the alternative row color
	
	.PARAMETER DefaultRowColor
		Specifies the color of the default row color
	
	.PARAMETER ForeColor
		Specifies the color of the text
	
	.PARAMETER BackColor
		Specifies the background color
	
	.PARAMETER ProperFormat
		Set the datagirdview to the proper format
	
	.PARAMETER FontFamily
		Specifies the the Font family to use
	
	.PARAMETER FontSize
		Specifies the Font size
	
	.PARAMETER HideRowHeader
		Hide the Row Header
	
	.PARAMETER ShowRowHeader
		Show the Row Header

	.PARAMETER HideColumnHeader
		Hide the Column Header
		
	.PARAMETER ShowColumnHeader
		Show the Column Header

	.EXAMPLE
		Set-WFDataGridView -DataGridView $datagridview1 -ProperFormat -FontFamily $listboxFontFamily.Text -FontSize $listboxFontSize.Text
	
	.EXAMPLE
		Set-WFDataGridView -DataGridView $datagridview1 -AlternativeRowColor -BackColor 'AliceBlue' -ForeColor 'Black'
	
	.EXAMPLE
		Set-WFDataGridView -DataGridView $datagridviewOutput -DefaultRowColor -BackColor 'Beige' -ForeColor 'Brown'
	
	.EXAMPLE
		Set-DataGridViewRowHeader -DataGridView $datagridview1 -HideRowHeader
	
		This will hide the Row Header

	.EXAMPLE
		Set-DataGridViewRowHeader -DataGridView $datagridview1 -ShowRowHeader

		This will show the Row Header

	.EXAMPLE
		Set-DataGridViewRowHeader -DataGridView $datagridview1 -HideColumnHeader
	
		This will hide the Column Header

	.EXAMPLE
		Set-DataGridViewRowHeader -DataGridView $datagridview1 -ShowColumnHeader

		This will show the Column Header

	.NOTES
		Author: Francois-Xavier Cat
		Twitter:@LazyWinAdm
		www.lazywinadmin.com
		github.com/lazywinadmin
#>
	
	[CmdletBinding(DefaultParameterSetName = 'ShowRowHeader',
				   SupportsShouldProcess = $true)]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[System.Windows.Forms.DataGridView]$DataGridView,
		
		[Parameter(ParameterSetName = 'AlternativeRowColor',
				   Mandatory = $true)]
		[Switch]$AlternativeRowColor,
		
		[Parameter(ParameterSetName = 'DefaultRowColor')]
		[Switch]$DefaultRowColor,
		
		[Parameter(ParameterSetName = 'AlternativeRowColor',
				   Mandatory = $true)]
		[Parameter(ParameterSetName = 'DefaultRowColor')]
		[System.Drawing.Color]$ForeColor,
		
		[Parameter(ParameterSetName = 'AlternativeRowColor',
				   Mandatory = $true)]
		[Parameter(ParameterSetName = 'DefaultRowColor')]
		[System.Drawing.Color]$BackColor,
		
		[Parameter(ParameterSetName = 'Proper',
				   Mandatory = $true)]
		[Switch]$ProperFormat,
		
		[Parameter(ParameterSetName = 'Proper')]
		[String]$FontFamily = "Consolas",
		
		[Parameter(ParameterSetName = 'Proper')]
		[Int]$FontSize = 10,
		
		[Parameter(ParameterSetName = 'HideRowHeader')]
		[Switch]$HideRowHeader,
		
		[Parameter(ParameterSetName = 'ShowRowHeader')]
		[Switch]$ShowRowHeader,
		
		[Parameter(ParameterSetName = 'HideColumnHeader')]
		[Switch]$HideColumnHeader,
		
		[Parameter(ParameterSetName = 'ShowColumnHeader')]
		[Switch]$ShowColumnHeader

	)
	
	BEGIN
	{
		Add-Type -AssemblyName System.Windows.Forms
	}
	PROCESS
	{
		if ($psboundparameters['AlternativeRowColor'])
		{
			IF ($PSCmdlet.ShouldProcess($DataGridView, "Set the Alternative row color. ForeColor: $ForeColor, BackColor: $BackColor"))
			{
				$DataGridView.AlternatingRowsDefaultCellStyle.ForeColor = $ForeColor
				$DataGridView.AlternatingRowsDefaultCellStyle.BackColor = $BackColor
			}
		}
		
		if ($psboundparameters['DefaultRowColor'])
		{
			IF ($PSCmdlet.ShouldProcess($DataGridView, "Set the Default row color. ForeColor: $ForeColor, BackColor: $BackColor"))
			{
				$DataGridView.RowsDefaultCellStyle.ForeColor = $ForeColor
				$DataGridView.RowsDefaultCellStyle.BackColor = $BackColor
			}
		}
		
		if ($psboundparameters['ProperFormat'])
		{
			IF ($PSCmdlet.ShouldProcess($DataGridView, "Set the Border Header Style to 'Raised', Border Style to 'Fixed3D', Selection Mode to 'FullRowSelected', Disable resizable row, Set the font to $FontFamily with a the size $FontSize"))
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
		}
		
		if ($psboundparameters['HideRowHeader'])
		{
			IF ($PSCmdlet.ShouldProcess($DataGridView, "Hide the Row Header"))
			{
				$DataGridView.RowHeadersVisible = $false
			}
		}
		if ($psboundparameters['ShowRowHeader'])
		{
			IF ($PSCmdlet.ShouldProcess($DataGridView, "Show the Row Header"))
			{
				$DataGridView.RowHeadersVisible = $true
			}
		}
		if ($psboundparameters['HideColumnHeader'])
		{
			IF ($PSCmdlet.ShouldProcess($DataGridView, "Hide the Column Header"))
			{
				$DataGridView.ColumnHeadersVisible = $false
			}
		}
		if ($psboundparameters['ShowColumnHeader'])
		{
			IF ($PSCmdlet.ShouldProcess($DataGridView, "Show the Column Header"))
			{
				$DataGridView.ColumnHeadersVisible = $true
			}
		}
	}
}