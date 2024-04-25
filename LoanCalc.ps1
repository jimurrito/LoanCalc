


function New-SWFRadialButton {
    param (
        $Text = "Insert-Name",
        $LocationX = 0,
        $LocationY = 0,
        $Location = (New-Object System.Drawing.Point($LocationX, $LocationY)),
        $AutoScale = $true
    )
    $RADIAL = New-Object System.Windows.Forms.RadioButton
    $RADIAL.Text = $Text
    $RADIAL.Location = $Location
    $RADIAL.AutoSize = $AutoScale
    return $RADIAL
}



# Load necessary .NET assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$form = New-Object System.Windows.Forms.Form 
$form.Text = "LoanCalc"
$form.Size = New-Object System.Drawing.Size(275, 320)
$form.StartPosition = "CenterScreen"
$form.AutoSize = $true
$form.MaximizeBox = $false
$form.TopMost = $true


# Create ButtonGroup
$SelectTypeBG = New-Object System.Windows.Forms.GroupBox
$SelectTypeBG.Text = "Find:"
$SelectTypeBG.Location = New-Object System.Drawing.Point(10, 0)
$SelectTypeBG.AutoSize = $true


# Create buttons
$MonthlyPayRADIAL = New-SWFRadialButton -Text "Monthly Payment" -LocationX 10 -LocationY 20
$TotalPayRADIAL = New-SWFRadialButton -Text "Total Payment" -LocationX 140 -LocationY 20
$NumoPayRADIAL = New-SWFRadialButton -Text "Number of Payments" -LocationX 10 -LocationY 45

$MonthlyPayRADIAL.add_CheckedChanged({
    if ($MonthlyPayRADIAL.checked) {Write-Host "checked!"}
})

# Add buttons to button group
$SelectTypeBG.Controls.Add($MonthlyPayRADIAL)
$SelectTypeBG.Controls.Add($TotalPayRADIAL)
$SelectTypeBG.Controls.Add($NumoPayRADIAL)

# Add the buttongroup to the form
$form.Controls.Add($SelectTypeBG)

# Show the form
$form.ShowDialog()