#Get public and private function definition files.
$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

#Dot source the files
Foreach ($import in @($Public + $Private))
{
	TRY
	{
		. $import.fullname
	}
	CATCH
	{
		Write-Error -Message "Failed to import function $($import.fullname): $_"
	}
}

# Create Aliases
New-Alias -Name Load-ListBox -value Import-WFListBoxItem -Description "SAPIEN Name"
New-Alias -Name Load-DataGridView -value Import-WFDataGridViewItem -Description "SAPIEN Name"
New-Alias -Name Refresh-DataGridView -value Update-WFDataGridView -Description "SAPIEN Name"

# Export all the functions
Export-ModuleMember -Function $Public.Basename -Alias *