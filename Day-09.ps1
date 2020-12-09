$Encode = Get-Content -Path C:\Temp\Encode.txt

# Part 1

$InvalidValue = foreach ($Index in 25..($Encode.Length - 1)) {
    $Preamble = $Encode[($Index - 25)..($Index -1)]

    $Valid = $false

    foreach ($Number in $Preamble) {
        $Match = $Preamble.Where({$_ -ne $Number -and $_ -eq ($Encode[$Index] - $Number)})

        if ($Match) {
            $Valid = $true
            break
        }
    }

    if (-not $Valid) {
        $Encode[$Index]
        break
    }
}

$InvalidValue

# Part 2

$Collection = @()
$Start = 0

:WhileLoop while ($true) {
    foreach ($Index in $Start..($Encode.Length - 1)) {
        [long] $Number = $Encode[$Index]

        if ($Number -ne [long] $InvalidValue) {
            $Collection += $Number

            $RunningTotal = 0

            foreach ($ConsecNum in $Collection) {
                $RunningTotal += $ConsecNum
            }

            if ($RunningTotal -eq [long] $InvalidValue) {
                ($Collection | Sort-Object)[0] + ($Collection | Sort-Object)[-1]
                break WhileLoop
            } elseif ($RunningTotal -gt [long] $InvalidValue) {
                $Collection = @()
                $Start += 1
                break
            }
        }
    }
}
