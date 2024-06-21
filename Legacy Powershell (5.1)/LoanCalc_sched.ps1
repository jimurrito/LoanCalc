param(
    [float]$TotalAmount = 1000,
    [int]$NumoPayments = 72,
    $APR = 0.01,
    $MonthlyInterest = ($APR / 12),
    [float]$MonthlyPayment = 100
)

# Load necessary .NET assembly
Add-Type -AssemblyName System.Windows.Forms

# Enables modern design from .net
[System.Windows.Forms.Application]::EnableVisualStyles()

# Create a new form
$form = New-Object System.Windows.Forms.Form 
$form.Text = "Amortization Schedule"
$form.Padding = New-Object System.Windows.Forms.Padding(15, 15, 15, 15)
#$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.StartPosition = "CenterScreen"
$form.AutoSize = $true
#$form.MaximizeBox = $false
#$form.TopMost = $true
$form.Width = 820
$form.Icon = New-Object System.Drawing.Icon("$PSScriptRoot/.assets/icon/favicon.ico")

# Create a new DataGridView
$dataGridView = New-Object System.Windows.Forms.DataGridView
$dataGridView.Dock = [System.Windows.Forms.DockStyle]::Fill

# Add the DataGridView to the form
$form.Controls.Add($dataGridView)

# Create a DataTable
$dataTable = New-Object System.Data.DataTable

# Add columns to the DataTable
$null = $dataTable.Columns.Add("Payment #", [int])
$null = $dataTable.Columns.Add("Year", [int])
$null = $dataTable.Columns.Add("Month", [string])
$null = $dataTable.Columns.Add("Payment", [string])
$null = $dataTable.Columns.Add("Interest", [string])
$null = $dataTable.Columns.Add("Principal", [string])
$null = $dataTable.Columns.Add("Remaining", [string])

#
# Schedule generator
[int]$NumoPaymentsAdjusted = 1
$TotalAmountAdjusted = $TotalAmount
$Date = Get-Date

#
# Create schedule
while ($true) {
    #
    # Get Interest
    $InterestPayment = ($TotalAmount * $MonthlyInterest)
    # Get Monthly payment post-interest
    $MonthlyPaymentAdjusted = ($MonthlyPayment - $InterestPayment)
    # Get new total
    $TotalAmountAdjusted = ($TotalAmount - $MonthlyPaymentAdjusted)
    # Catch for payment overflow. | if less than 0, adjusted payment is the orginal total
    if ($TotalAmountAdjusted -lt 0) { $MonthlyPayment = $TotalAmount; $MonthlyPaymentAdjusted = $TotalAmount; $TotalAmountAdjusted = 0; $InterestPayment = 0}
    # Create rows and add to dataTable
    $row = $dataTable.NewRow()
    $row["Payment #"] = $NumoPaymentsAdjusted
    $row["Year"] = ($Date).Year
    $row["Month"] = (Get-Date $Date -Format MMMM)
    $row["Payment"] = '$' + (([math]::round($MonthlyPayment, 2)).ToString("F2"))
    $row["Interest"] = '$' + (([math]::round($InterestPayment, 2)).ToString("F2"))
    $row["Principal"] = '$' + (([math]::round($MonthlyPaymentAdjusted, 2)).ToString("F2"))
    $row["Remaining"] = '$' + (([math]::round($TotalAmountAdjusted, 2)).ToString("F2"))
    $dataTable.Rows.Add($row)
    # Increment data
    $NumoPaymentsAdjusted += 1
    $Date = $Date.AddMonths(1)
    $TotalAmount = $TotalAmountAdjusted
    # Decide if we need to kill the loop
    if (($TotalAmountAdjusted -eq 0)) {
        break
    }
}

# Bind the DataTable to the DataGridView
$dataGridView.DataSource = $dataTable

$null = $form.ShowDialog()