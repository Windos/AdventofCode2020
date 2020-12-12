$Navigation = Get-Content -Path 'Navigation.txt'

# Part 1

$Facing = 90

$xShift = 0
$yShift = 0

foreach ($Instruction in $Navigation) {
    $null = $Instruction -match '(?<Action>\w)(?<Distance>\d+)'
    switch ($Matches.Action) {
        'N' {$yShift += [int] $Matches.Distance}
        'S' {$yShift -= [int] $Matches.Distance}
        'E' {$xShift += [int] $Matches.Distance}
        'W' {$xShift -= [int] $Matches.Distance}
        'L' {$Facing -= [int] $Matches.Distance}
        'R' {$Facing += [int] $Matches.Distance}
        'F' {
            switch ($Facing) {
                0 {$yShift += [int] $Matches.Distance}
                90 {$xShift += [int] $Matches.Distance}
                180 {$yShift -= [int] $Matches.Distance}
                270 {$xShift -= [int] $Matches.Distance}
            }
        }
    }

    if ($Facing -ge 360) {
        $Facing -= 360
    }

    if ($Facing -lt 0) {
        $Facing += 360
    }
}

[Math]::Abs($xShift) + [Math]::Abs($yShift)

# Part 2

$xShift = 0
$yShift = 0

$WaypointX = 10
$WaypointY = 1

foreach ($Instruction in $Navigation) {
    $null = $Instruction -match '(?<Action>\w)(?<Distance>\d+)'
    switch ($Matches.Action) {
        'N' {$WaypointY += [int] $Matches.Distance}
        'S' {$WaypointY -= [int] $Matches.Distance}
        'E' {$WaypointX += [int] $Matches.Distance}
        'W' {$WaypointX -= [int] $Matches.Distance}
        'L' {
            foreach ($Rotation in 1..([int] $Matches.Distance / 90)) {
                $NextWaypointX = $WaypointY * -1
                $NextWaypointY = $WaypointX
                $WaypointX = $NextWaypointX
                $WaypointY = $NextWaypointY
            }
        }
        'R' {
            foreach ($Rotation in 1..([int] $Matches.Distance / 90)) {
                $NextWaypointX = $WaypointY
                $NextWaypointY = $WaypointX * -1
                $WaypointX = $NextWaypointX
                $WaypointY = $NextWaypointY
            }
        }
        'F' {
            $xShift += $WaypointX * [int] $Matches.Distance
            $yShift += $WaypointY * [int] $Matches.Distance
        }
    }
}

[Math]::Abs($xShift) + [Math]::Abs($yShift)
