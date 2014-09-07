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
