
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

function New-SWFButton {
    param (
        $Text = "Insert-Name",
        $LocationX = 0,
        $LocationY = 0,
        $Location = (New-Object System.Drawing.Point($LocationX, $LocationY)),
        $AutoScale = $true
    )
    $BUTTON = New-Object System.Windows.Forms.Button
    $BUTTON.Text = $Text
    $BUTTON.Location = $Location
    $BUTTON.AutoSize = $AutoScale
    return $BUTTON
}

function New-SWFTextbox {
    param (
        $Text = "default",
        $LocationX = 0,
        $LocationY = 0,
        $Location = (New-Object System.Drawing.Point($LocationX, $LocationY)),
        $SizeW = 100,
        $SizeH = 20,
        $Size = (New-Object System.Drawing.Size($SizeW, $SizeH)),
        $AutoScale = $true
    )
    $BUTTON = New-Object System.Windows.Forms.TextBox
    $BUTTON.Text = $Text
    $BUTTON.Location = $Location
    $BUTTON.Size = $Size
    $BUTTON.AutoSize = $AutoScale
    return $BUTTON
}

function New-SWFLabel {
    param (
        $Text = "default",
        $LocationX = 0,
        $LocationY = 0,
        $Location = (New-Object System.Drawing.Point($LocationX, $LocationY)),
        $AutoScale = $true
    )
    $LABEL = New-Object System.Windows.Forms.Label
    $LABEL.Text = $Text
    $LABEL.Location = $Location
    $LABEL.AutoSize = $AutoScale
    return $LABEL
}

function New-SWFGroupBox {
    param (
        $Text = "Insert-Name",
        $LocationX = 0,
        $LocationY = 0,
        $Location = (New-Object System.Drawing.Point($LocationX, $LocationY)),
        $SizeW = 0,
        $SizeH = 0,
        $Size = (New-Object System.Drawing.Size($SizeW, $SizeH)),
        $AutoScale = $true
    )
    $BOX = New-Object System.Windows.Forms.GroupBox
    $BOX.Text = $Text
    $BOX.Location = $Location
    $BOX.Size = $Size
    $BOX.AutoSize = $AutoScale
    return $BOX
}

function Get-SWFBufferLocation {
    # Returns sided coords that account for a buffer
    param (
        $Target = $1,
        $Side = "right",
        $Buffer = 10
    )
    # get loc coords (Top-Left)
    $ObjLocX = $Target.Location.x 
    $ObjLocY = $Target.Location.y
    # Get size
    $ObjSizeW = $Target.Size.Width
    $ObjSizeH = $Target.Size.Height
    # The side of the obj that we need the coords to.
    switch ($Side.ToLower()) {
        "right" { 
            return ($ObjLocX + $ObjSizeW + $Buffer)
        }
        "bottom" { 
            return ($ObjLocY + $ObjSizeH + $Buffer)
        }
        Default {}
    }
}

#
# CONSTANTS
$WINDOWW = 280
$WINDOWH = 440
$OBJBUFFERX = 10


# Load necessary .NET assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$form = New-Object System.Windows.Forms.Form 
$form.Text = "LoanCalc"
$form.Size = New-Object System.Drawing.Size($WINDOWW, $WINDOWH)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.StartPosition = "CenterScreen"
$form.AutoSize = $true
$form.MaximizeBox = $false
$form.TopMost = $true
$form.Icon = New-Object System.Drawing.Icon("./favicon.ico")
# (left, top, right, bottom)
$form.padding = New-Object System.Windows.Forms.Padding(0, 0, 0, 15)


#
# <Title>
$TitleLabel = New-SWFLabel -Text "Loan Amoritization Calculator - by Jimurrito" -LocationX $OBJBUFFERX -LocationY 20; $form.Controls.Add($TitleLabel)


#
# <Input Area>
# Input for total loan amount
$TotalAmountGroupBox = New-SWFGroupBox -Text "Total ($):" -LocationX $OBJBUFFERX -LocationY (Get-SWFBufferLocation -Side "bottom" -Target $TitleLabel)
$form.Controls.Add($TotalAmountGroupBox)
$TotalAmountInput = New-SWFTextbox -Text 1000 -LocationX ($OBJBUFFERX / 2) -LocationY 20; $TotalAmountGroupBox.Controls.Add($TotalAmountInput)
# Number of payments/months
$NumoPayGroupBox = New-SWFGroupBox -Text "# of payments:" -LocationX (Get-SWFBufferLocation -Target $TotalAmountGroupBox -Buffer 20) -LocationY  (Get-SWFBufferLocation -Side "bottom" -Target $TitleLabel)
$form.Controls.Add($NumoPayGroupBox)
$NumoPayInput = New-SWFTextbox -Text 72 -LocationX ($OBJBUFFERX / 2) -LocationY 20; $NumoPayGroupBox.Controls.Add($NumoPayInput)
# APR
$APRGroupBox = New-SWFGroupBox -Text "APR (%):" -LocationX 10  -LocationY (Get-SWFBufferLocation -Side "bottom" -Target $TotalAmountGroupBox)
$form.Controls.Add($APRGroupBox)
$APRInput = New-SWFTextbox -Text 1.0 -LocationX ($OBJBUFFERX / 2) -LocationY 20; $APRGroupBox.Controls.Add($APRInput)
# Payment Amount
$PayAmountGroupBox = New-SWFGroupBox -Text "Payment ($):" -LocationX (Get-SWFBufferLocation -Target $APRGroupBox -Buffer 20)  -LocationY (Get-SWFBufferLocation -Side "bottom" -Target $NumoPayGroupBox)
$form.Controls.Add($PayAmountGroupBox)
$PayAmountInput = New-SWFTextbox -Text 100 -LocationX ($OBJBUFFERX / 2) -LocationY 20; $PayAmountGroupBox.Controls.Add($PayAmountInput)


#
# <Select Calc>
# Group Box
$SelectBox = New-SWFGroupBox -Text "Find:" -LocationX $OBJBUFFERX -LocationY (Get-SWFBufferLocation -Side "bottom" -Target $APRGroupBox)
$form.Controls.Add($SelectBox)
$SelectBox.Size = New-Object System.Drawing.Size(($form.Size.Width - $OBJBUFFERX - 30), 0)
# radial buttons
$MonthlyPayRADIAL = New-SWFRadialButton -Text "Monthly Payment" -LocationX $OBJBUFFERX -LocationY 20
$SelectBox.Controls.Add($MonthlyPayRADIAL)
$MonthlyPayRADIAL.add_checkedchanged(
    {
        $TotalAmountInput.Enabled = $true
        $NumoPayInput.Enabled = $true
        $PayAmountInput.Enabled = $false
    }
)
#
$TotalPayRADIAL = New-SWFRadialButton -Text "Total Payment" -LocationX (Get-SWFBufferLocation -Target $MonthlyPayRADIAL -Buffer 5) -LocationY 20
$SelectBox.Controls.Add($TotalPayRADIAL)
$TotalPayRADIAL.add_checkedchanged(
    {
        $TotalAmountInput.Enabled = $false
        $NumoPayInput.Enabled = $true
        $PayAmountInput.Enabled = $true
    }
)
#
$NumoPayRADIAL = New-SWFRadialButton -Text "Number of Payments" -LocationX $OBJBUFFERX -LocationY (Get-SWFBufferLocation -Side "bottom" -Target $MonthlyPayRADIAL -Buffer 5)
$SelectBox.Controls.Add($NumoPayRADIAL)
$NumoPayRADIAL.add_checkedchanged(
    {
        $TotalAmountInput.Enabled = $true
        $NumoPayInput.Enabled = $false
        $PayAmountInput.Enabled = $true
    }
)


#
# <Toggle for schedule generator>
# Group Box
$SchedToggleBox = New-SWFGroupBox -Text "Generate Schedule:" -LocationX $OBJBUFFERX -LocationY (Get-SWFBufferLocation -Side "bottom" -Target $SelectBox)
$form.Controls.Add($SchedToggleBox)
$SchedToggleBox.Size = New-Object System.Drawing.Size(($form.Size.Width - $OBJBUFFERX - 30), 0)
# radial buttons
$ONRADIAL = New-SWFRadialButton -Text "On" -LocationX $OBJBUFFERX -LocationY 20
$SchedToggleBox.Controls.Add($ONRADIAL)
$OFFRADIAL = New-SWFRadialButton -Text "Off" -LocationX (Get-SWFBufferLocation -Target $ONRADIAL) -LocationY 20
$SchedToggleBox.Controls.Add($OFFRADIAL)


#
# <Calc button>
$CalcButton = New-SWFButton -Text "Calculate"
$CalcButton.Location = New-Object System.Drawing.Point((($form.Size.Width / 2) - ($CalcButton.Size.Width / 1.5)), (Get-SWFBufferLocation -Side "bottom" -Target $SchedToggleBox))
$form.Controls.Add($CalcButton)


#
# <Calc Function>
$CalcButton.add_click({
        #
        [int]$TotalAmount = $TotalAmountInput.Text
        [int]$NumoPayments = $NumoPayInput.Text
        $APR = ($APRInput.Text / 100)
        $MonthlyInterest = $APR / 12
        [int]$MonthlyPayment = $PayAmountInput.Text

        # Clear result prior
        if ($form.Controls.Count -gt 8) {
            # Remove the last control
            $form.Controls.RemoveAt(($form.Controls.Count - 1))
        }
     
        # If calc monthly payment
        if ($MonthlyPayRADIAL.Checked) {
            # get payment amoritzation
            $Out = [Math]::Round((($MonthlyInterest * $TotalAmount) / (1 - ([Math]::Pow((1 + $MonthlyInterest), - $NumoPayments)))), 2)
            # Create Output box
            $OutBox = New-SWFGroupBox -Text "Monthly Payment:"
            $form.Controls.add($OutBox)
            # Create Output label
            $OutValue = New-SWFLabel -Text ('$' + $Out)
            $OutBox.Controls.add($OutValue)
        }
        elseif ($TotalPayRADIAL.Checked) {
            # get TotalAmpunt amoritzation
            $Out = [Math]::Round((($MonthlyPayment * (1 - [Math]::Pow((1 + $MonthlyInterest), - $NumoPayments))) / $MonthlyInterest), 2)
            # Create Output box
            $OutBox = New-SWFGroupBox -Text "Total Amount:"
            $form.Controls.add($OutBox)
            # Create Output label
            $OutValue = New-SWFLabel -Text ('$' + $Out)
            $OutBox.Controls.add($OutValue)
        }
        elseif ($NumoPayRADIAL.Checked) {
            # get number of payments amoritzation
            $Out = [Math]::Round(( - ([Math]::Log((1 - (($MonthlyInterest * $TotalAmount) / $MonthlyPayment))) / [Math]::Log(1 + $MonthlyInterest))), 1)
            # Create Output box
            $OutBox = New-SWFGroupBox -Text "# of payments:"
            $form.Controls.add($OutBox)
            # Create Output label
            $OutValue = New-SWFLabel -Text $Out
            $OutBox.Controls.add($OutValue)
        }
        # Update and project Output
        $OutBox.size = New-Object System.Drawing.Size(120, ($OutValue.size.Height + ($OBJBUFFERX)))
        $OutBox.Location = New-Object System.Drawing.Point((($form.Size.Width / 2) - ($OutBox.Size.Width / 1.7)), (Get-SWFBufferLocation -Side "bottom" -Target $CalcButton -Buffer 15))
        $OutValue.Location = New-Object System.Drawing.Point((($Outbox.Size.Width / 2) - ($OutValue.Size.Width / 1.7)), ($OBJBUFFERX * 2.25))
    })


#
# <Pre-load>
$MonthlyPayRADIAL.Checked = $true
$OFFRADIAL.Checked = $true

# Show the form
$form.ShowDialog()