$MapInput = Get-Content -Path 'Map.txt'

function Measure-Trajectory {
    param (
        [string[]] $Map,
        [int] $Right,
        [int] $Down
    )

    $x = 0
    $y = 0

    $hits = 0

    while ($y -le 322) {
        if ($x -gt 30) {
            $x = $x - 31
        }

        if ($Map[$y][$x] -eq '#') {
            $hits += 1
        }

        $x += $Right
        $y += $Down
    }

    $hits
}

# Part 1

Measure-Trajectory -Map $MapInput -Right 3 -Down 1

# Part 2

$Slope1 = Measure-Trajectory -Map $MapInput -Right 1 -Down 1
$Slope2 = Measure-Trajectory -Map $MapInput -Right 3 -Down 1
$Slope3 = Measure-Trajectory -Map $MapInput -Right 5 -Down 1
$Slope4 = Measure-Trajectory -Map $MapInput -Right 7 -Down 1
$Slope5 = Measure-Trajectory -Map $MapInput -Right 1 -Down 2

$Slope1 * $Slope2 * $Slope3 * $Slope4 * $Slope5
