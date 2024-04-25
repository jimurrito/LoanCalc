# Load necessary .NET assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$form = New-Object System.Windows.Forms.Form 
$form.Text = "My First PowerShell Form"
$form.Size = New-Object System.Drawing.Size(300,200) 
$form.StartPosition = "CenterScreen"

# Create a button
$button = New-Object System.Windows.Forms.Button 
$button.Location = New-Object System.Drawing.Point(100,80) 
$button.Size = New-Object System.Drawing.Size(100,20) 
$button.Text = "Click me"

# Add a click event
$button.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Hello, World!", "My Dialog Box")
})

# Add the button to the form
$form.Controls.Add($button)

# Show the form
$form.ShowDialog()
