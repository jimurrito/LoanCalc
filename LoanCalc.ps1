


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

function New-SWFGroupBox {
    param (
        $Text = "Insert-Name",
        $LocationX = 0,
        $LocationY = 0,
        $Location = (New-Object System.Drawing.Point($LocationX, $LocationY)),
        $AutoScale = $true
    )
    $BOX = New-Object System.Windows.Forms.GroupBox
    $BOX.Text = $Text
    $BOX.Location = $Location
    $BOX.AutoSize = $AutoScale
    return $BOX
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

# Create Groupbox
$SelectTypeGB = New-SWFGroupBox -Text "Find:" -LocationX 10
$MonthlyPayGB = New-SWFGroupBox -Text "MPInput:" -LocationX 10 -LocationY 105
$TotalPayGB = New-SWFGroupBox -Text "TPInput:" -LocationX 10 -LocationY 100
$NumoPayGB = New-SWFGroupBox -Text "NPInput:" -LocationX 10 -LocationY 100


# Create buttons
$MonthlyPayRADIAL = New-SWFRadialButton -Text "Monthly Payment" -LocationX 10 -LocationY 20
$MonthlyPayRADIAL.Checked = $true   # defaults to this toggle
$MonthlyPayRADIAL.add_CheckedChanged({ # Ran when the radial button changes states
    if ($MonthlyPayRADIAL.checked) {
        $form.Controls.Add($MonthlyPayGB)
        $form.Controls.Remove($TotalPayGB)
        $form.Controls.Remove($NumoPayGB)
    }
})

$TotalPayRADIAL = New-SWFRadialButton -Text "Total Payment" -LocationX 140 -LocationY 20
$TotalPayRADIAL.add_CheckedChanged({ # Ran when the radial button changes states
    if ($TotalPayRADIAL.checked) {
        $form.Controls.Add($TotalPayGB)
        $form.Controls.Remove($MonthlyPayGB)
        $form.Controls.Remove($NumoPayGB)
    }
})

$NumoPayRADIAL = New-SWFRadialButton -Text "Number of Payments" -LocationX 10 -LocationY 45
$NumoPayRADIAL.add_CheckedChanged({ # Ran when the radial button changes states
    if ($NumoPayRADIAL.checked) {
        $form.Controls.Add($NumoPayGB)
        $form.Controls.Remove($TotalPayGB)
        $form.Controls.Remove($MonthlyPayGB)
    }
})

$SelectTypeGB.Controls.Add($MonthlyPayRADIAL)
$SelectTypeGB.Controls.Add($TotalPayRADIAL)
$SelectTypeGB.Controls.Add($NumoPayRADIAL)


# Add the buttongroup to the form
$form.Controls.Add($SelectTypeGB)


# Preload
if ($MonthlyPayRADIAL.checked) {
    $form.Controls.Add($MonthlyPayGB)
}

# Show the form
$form.ShowDialog()