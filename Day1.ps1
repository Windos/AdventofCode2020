$ExpenseReport = [System.Collections.ArrayList]::new()

$List = Get-Content -Path 'Input.txt'

foreach ($Line in $List) {
    $null = $ExpenseReport.Add([int] $Line)
}

# Part 1

foreach ($Entry in $ExpenseReport) {
    $Remainder = 2020 - $Entry
    $Match = $ExpenseReport | Where-Object {$_ -eq $Remainder}
    if ($Match) {
        $Entry * $Match
        break
    }
}

# Part 2

:ReportLoop foreach ($Entry in $ExpenseReport) {
    $Remainder = 2020 - $Entry

    foreach ($SecondEntry in ($ExpenseReport | Where-Object {$_ -ne $Entry -and ($_ + $Entry) -lt 2020})) {
        $SecondRemainder = $Remainder - $SecondEntry

        $Match = $ExpenseReport | Where-Object {$_ -eq ($Remainder - $SecondRemainder) -and $_ -ne $Entry}
        $SecondMatch = $ExpenseReport | Where-Object {$_ -eq $SecondRemainder -and $_ -ne $Entry}

        if ($Match -and $SecondMatch) {
            $Entry * $Match * $SecondMatch
            break ReportLoop
        }
    }
}
