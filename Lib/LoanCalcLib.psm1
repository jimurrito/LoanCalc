# 
# Library File
#
# Load necessary .NET assembly
Add-Type -AssemblyName System.Windows.Forms
#
#
function New-SWFRadialButton {
    [OutputType([System.Windows.Forms.RadioButton])]
    param (
        [string]$Text = "Insert-Name",
        [int]$LocationX = 0,
        [int]$LocationY = 0,
        [System.Drawing.Point]$Location = (New-Object System.Drawing.Point($LocationX, $LocationY)),
        [bool]$AutoScale = $true
    )
    $RADIAL = New-Object System.Windows.Forms.RadioButton
    $RADIAL.Text = $Text
    $RADIAL.Location = $Location
    $RADIAL.AutoSize = $AutoScale
    return $RADIAL
}
#
#
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
#
#
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
#
#
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
#
#
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
#
#
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