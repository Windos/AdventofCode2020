$SeatMap = Get-Content -Path 'SeatMap.txt'

$MaxRowIndex = $SeatMap.Length - 1
$MaxColIndex = $SeatMap[0].Length - 1

while ($true) {
    $NextSeatMap = $SeatMap.Clone()
    $Change = $false

    foreach ($Row in 0..$MaxRowIndex) {
        foreach ($Column in 0..$MaxColIndex) {
            $Char = $SeatMap[$Row][$Column]

            if ($Char -ne '.') {
                $Neighbours = 0

                #UL
                if ($Row -ne 0 -and $Column -ne 0) {
                    if ($SeatMap[$Row - 1][$Column - 1] -eq '#') {
                        $Neighbours += 1
                    }
                }

                #U
                if ($Row -ne 0) {
                    if ($SeatMap[$Row - 1][$Column] -eq '#') {
                        $Neighbours += 1
                    }
                }

                #UR
                if ($Row -ne 0 -and $Column -ne $MaxColIndex) {
                    if ($SeatMap[$Row - 1][$Column + 1] -eq '#') {
                        $Neighbours += 1
                    }
                }

                #L
                if ($Column -ne 0) {
                    if ($SeatMap[$Row][$Column - 1] -eq '#') {
                        $Neighbours += 1
                    }
                }

                #R
                if ($Column -ne $MaxColIndex) {
                    if ($SeatMap[$Row][$Column + 1] -eq '#') {
                        $Neighbours += 1
                    }
                }

                #DL
                if ($Row -ne $MaxRowIndex -and $Column -ne 0) {
                    if ($SeatMap[$Row + 1][$Column - 1] -eq '#') {
                        $Neighbours += 1
                    }
                }

                #D
                if ($Row -ne $MaxRowIndex) {
                    if ($SeatMap[$Row + 1][$Column] -eq '#') {
                        $Neighbours += 1
                    }
                }

                #DR
                if ($Row -ne $MaxRowIndex -and $Column -ne $MaxColIndex) {
                    if ($SeatMap[$Row + 1][$Column + 1] -eq '#') {
                        $Neighbours += 1
                    }
                }

                if ($Char -eq 'L' -and $Neighbours -eq 0) {
                    $NextSeatMap[$Row] = $NextSeatMap[$Row].ToCharArray()
                    $NextSeatMap[$Row][$Column] = '#'
                    $NextSeatMap[$Row] = $NextSeatMap[$Row] -join ''
                    $Change = $true
                }

                if ($Char -eq '#' -and $Neighbours -ge 4) {
                    $NextSeatMap[$Row] = $NextSeatMap[$Row].ToCharArray()
                    $NextSeatMap[$Row][$Column] = 'L'
                    $NextSeatMap[$Row] = $NextSeatMap[$Row] -join ''
                    $Change = $true
                }
            }
        }
    }

    if (-not $Change) {
        $OccupiedSeats = 0
        foreach ($Row in 0..$MaxRowIndex) {
            $OccupiedSeats += $SeatMap[$Row].ToCharArray().Where({$_ -eq '#'}).Count
        }
        $OccupiedSeats
        break
    } else {
        $SeatMap = $NextSeatMap.Clone()
    }
}
