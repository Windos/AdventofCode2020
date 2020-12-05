$BoardingPasses = Get-Content -Path 'C:\Users\windo\OneDrive - ToastIT\Random PowerShell Hackery\BoardingPasses.txt'

$SeatIDs = foreach ($BoardingPass in $BoardingPasses) {
    $RowsLower = 0
    $RowsUpper = 127

    foreach ($i in 0..6) {
        if ($BoardingPass[$i] -eq 'F') {
            $RowsUpper = [math]::Floor(($RowsLower + $RowsUpper) / 2)
        } elseif ($BoardingPass[$i] -eq 'B') {
            $RowsLower = [math]::Ceiling(($RowsLower + $RowsUpper) / 2)
        }
    }

    $Row = $RowsLower

    $ColumnLower = 0
    $ColumnUpper = 7

    foreach ($i in 7..9) {
        if ($BoardingPass[$i] -eq 'L') {
            $ColumnUpper = [math]::Floor(($ColumnLower + $ColumnUpper) / 2)
        } elseif ($BoardingPass[$i] -eq 'R') {
            $ColumnLower = [math]::Ceiling(($ColumnLower + $ColumnUpper) / 2)
        }
    }

    $Column = $ColumnLower

    $SeatID = ($Row * 8) + $Column
    $SeatID
}

# Part 1

($SeatIDs | Sort-Object)[-1]

# Part 2

$SeatNoNeighbour = foreach ($SeatID in $SeatIDs) {
    $Prev = $SeatIDs | Where-Object {$_ -eq ($SeatID - 1)}
    $Next = $SeatIDs | Where-Object {$_ -eq ($SeatID + 1)}

    if (-not $Prev -or -not $Next) {
        $SeatID
    }
}

# Should be four seats here, first and last are expected.
# This find the seat inbetween the two with a missing neighbour

($SeatNoNeighbour[1] + $SeatNoNeighbour[2]) / 2
