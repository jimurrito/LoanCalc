


function Get-MonthlyPayment {
    param (
        $APR,
        $MonthInt = ($APR / 12),
        $Total,
        $NumPays
    )
    ($MonthInt * $Total) / (1 - [Math]::Pow((1 + $MonthInt), - $NumPays))    
}


function Get-TotalPayment {
    param (
        $APR,
        $MonthInt = ($APR / 12),
        $MonthPayment,
        $NumPays
    )
    ($MonthPayment * (1 - [Math]::Pow((1 + $MonthInt), - $NumPays))) / $MonthInt
}


function Get-NumoPayment {
    param (
        $APR,
        $MonthInt = ($APR / 12),
        $MonthPayment,
        $Total
    )
    - ([Math]::Log((1 - (($MonthInt * $Total) / $MonthPayment))) / [Math]::Log(1 + $MonthInt))
}








$MonthlyPayment = Get-MonthlyPayment -APR 0.01 -Total 500 -NumPays 10
$MonthlyPayment
Get-TotalPayment -APR 0.01 -MonthPayment $MonthlyPayment -NumPays 10
Get-NumoPayment -APR 0.01 -MonthPayment $MonthlyPayment -Total 500




