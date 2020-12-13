$Timetable = Get-Content -Path C:\Temp\Timetable.txt

# Part 1

$Earliest = [int] $Timetable[0]
$Buses = $Timetable[1] -split ',' | Where-Object {$_ -ne 'x'} | ForEach-Object {[int] $_}

$Timings = @()

foreach ($Bus in $Buses) {
    $Departure = 0
    while ($Departure -le $Earliest) {
        $Departure += $Bus
    }
    $Timings += [PSCustomObject] @{
        BusID = $Bus
        Closest = $Departure
    }
}

$TargetBus = ($Timings | Sort-Object Closest)[0]
$WaitTime = $TargetBus.Closest - $Earliest

$TargetBus.BusID * $WaitTime

# Part 2
# Credit for solution: https://github.com/LennardF1989/AdventOfCode2020/blob/master/Src/AdventOfCode2020/Days/Day13.cs#L198

$Buses = $Timetable[1] -split ',' | ForEach-Object {if ($_ -eq 'x') {0} else {[int] $_}}

[long] $Timestamp = 0
[long] $Increment = $Buses[0]
$Offset = 1

while ($Offset -lt $Buses.Count) {
    if ($Buses[$Offset] -eq 0) {
        $Offset += 1
        continue
    }

    $Timestamp += $Increment

    if (($Timestamp + $Offset) % $Buses[$Offset] -ne 0) {
        continue
    }

    $Increment *= $Buses[$Offset]

    $Offset += 1
}

$Timestamp
