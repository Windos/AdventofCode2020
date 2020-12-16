$StartingNumbers = 0,3,6

# This takes a _while_ when you increase the number of turns
$FinalTurn = 2020

function Play-Round {
    param (
        $Number
    )

    if ($null -eq $NumberHistory[[string] $Number]) {
        $TurnHistory = [System.Collections.ArrayList]::new()
        $null = $TurnHistory.Add($Turn)
        $NumberHistory[[string] $Number] = $TurnHistory
        0
    } else {
        $LastTurn = $NumberHistory[[string] $Number][-1]
        $null = $NumberHistory[[string] $Number].Add($Turn)
        $LastTurn
    }
}


$NumberHistory = @{}
$Turn = 1

foreach ($Number in $StartingNumbers) {
    $LastSpoken = Play-Round -Number $Number
    $Turn += 1
}

while ($Turn -lt $FinalTurn) {
    $LastTurn = Play-Round -Number $LastSpoken

    $LastSpoken = if ($LastTurn -ne 0) {
        $Turn - $LastTurn
    } else {
        0
    }

    $Turn += 1
}

$LastSpoken
