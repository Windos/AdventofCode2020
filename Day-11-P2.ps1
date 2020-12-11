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
                $FocusRow = $Row
                $FocusCol = $Column

                while ($true) {
                    if ($FocusRow -ne 0 -and $FocusCol -ne 0) {
                        if ($SeatMap[$FocusRow - 1][$FocusCol - 1] -eq '#') {
                            $Neighbours += 1
                            break
                        } elseif ($SeatMap[$FocusRow - 1][$FocusCol - 1] -eq 'L') {
                            break
                        } elseif ($SeatMap[$FocusRow - 1][$FocusCol - 1] -eq '.') {
                            $FocusRow = $FocusRow - 1
                            $FocusCol = $FocusCol - 1
                        }
                    } else {
                        break
                    }
                }

                #U
                $FocusRow = $Row

                while ($true) {
                    if ($FocusRow -ne 0) {
                        if ($SeatMap[$FocusRow - 1][$Column] -eq '#') {
                            $Neighbours += 1
                            break
                        }  elseif ($SeatMap[$FocusRow - 1][$Column] -eq 'L') {
                            break
                        } elseif ($SeatMap[$FocusRow - 1][$Column] -eq '.') {
                            $FocusRow = $FocusRow - 1
                        }
                    } else {
                        break
                    }
                }

                #UR
                $FocusRow = $Row
                $FocusCol = $Column

                while ($true) {
                    if ($FocusRow -ne 0 -and $FocusCol -ne $MaxColIndex) {
                        if ($SeatMap[$FocusRow - 1][$FocusCol + 1] -eq '#') {
                            $Neighbours += 1
                            break
                        } elseif ($SeatMap[$FocusRow - 1][$FocusCol + 1] -eq 'L') {
                            break
                        } elseif ($SeatMap[$FocusRow - 1][$FocusCol + 1] -eq '.') {
                            $FocusRow = $FocusRow - 1
                            $FocusCol = $FocusCol + 1
                        }
                    } else {
                        break
                    }
                }

                #L
                $FocusCol = $Column

                while ($true) {
                    if ($FocusCol -ne 0) {
                        if ($SeatMap[$Row][$FocusCol - 1] -eq '#') {
                            $Neighbours += 1
                            break
                        }  elseif ($SeatMap[$Row][$FocusCol - 1] -eq 'L') {
                            break
                        } elseif ($SeatMap[$Row][$FocusCol - 1] -eq '.') {
                            $FocusCol = $FocusCol - 1
                        }
                    } else {
                        break
                    }
                }

                #R
                $FocusCol = $Column

                while ($true) {
                    if ($FocusCol -ne $MaxColIndex) {
                        if ($SeatMap[$Row][$FocusCol + 1] -eq '#') {
                            $Neighbours += 1
                            break
                        }  elseif ($SeatMap[$Row][$FocusCol + 1] -eq 'L') {
                            break
                        } elseif ($SeatMap[$Row][$FocusCol + 1] -eq '.') {
                            $FocusCol = $FocusCol + 1
                        }
                    } else {
                        break
                    }
                }

                #DL
                $FocusRow = $Row
                $FocusCol = $Column

                while ($true) {
                    if ($FocusRow -ne $MaxRowIndex -and $FocusCol -ne 0) {
                        if ($SeatMap[$FocusRow + 1][$FocusCol - 1] -eq '#') {
                            $Neighbours += 1
                            break
                        } elseif ($SeatMap[$FocusRow + 1][$FocusCol - 1] -eq 'L') {
                            break
                        } elseif ($SeatMap[$FocusRow + 1][$FocusCol - 1] -eq '.') {
                            $FocusRow = $FocusRow + 1
                            $FocusCol = $FocusCol - 1
                        }
                    } else {
                        break
                    }
                }

                #D
                $FocusRow = $Row

                while ($true) {
                    if ($FocusRow -ne $MaxRowIndex) {
                        if ($SeatMap[$FocusRow + 1][$Column] -eq '#') {
                            $Neighbours += 1
                            break
                        }  elseif ($SeatMap[$FocusRow + 1][$Column] -eq 'L') {
                            break
                        } elseif ($SeatMap[$FocusRow + 1][$Column] -eq '.') {
                            $FocusRow = $FocusRow + 1
                        }
                    } else {
                        break
                    }
                }

                #DR
                $FocusRow = $Row
                $FocusCol = $Column

                while ($true) {
                    if ($FocusRow -ne $MaxRowIndex -and $FocusCol -ne $MaxColIndex) {
                        if ($SeatMap[$FocusRow + 1][$FocusCol + 1] -eq '#') {
                            $Neighbours += 1
                            break
                        } elseif ($SeatMap[$FocusRow + 1][$FocusCol + 1] -eq 'L') {
                            break
                        } elseif ($SeatMap[$FocusRow + 1][$FocusCol + 1] -eq '.') {
                            $FocusRow = $FocusRow + 1
                            $FocusCol = $FocusCol + 1
                        }
                    } else {
                        break
                    }
                }

                if ($Char -eq 'L' -and $Neighbours -eq 0) {
                    $NextSeatMap[$Row] = $NextSeatMap[$Row].ToCharArray()
                    $NextSeatMap[$Row][$Column] = '#'
                    $NextSeatMap[$Row] = $NextSeatMap[$Row] -join ''
                    $Change = $true
                }

                if ($Char -eq '#' -and $Neighbours -ge 5) {
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
