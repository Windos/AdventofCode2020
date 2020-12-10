$Adapters = (Get-Content -Path C:\Temp\Adapters.txt).ForEach({[int] $_}) | Sort-Object

# Part 1

$1s = 0
$3s = 1
$Last = 0

foreach ($Adapter in $Adapters) {
    if (($Adapter - $Last) -eq 1) {$1s += 1}
    elseif (($Adapter - $Last) -eq 3) {$3s += 1}

    $Last = $Adapter
}

$1s * $3s

# Part 2

$Adapters = ($Adapters += 0) | Sort-Object -Descending

$End = $Adapters[0] + 3
$Chains = @{$End = [long] 1}

foreach ($Adapter in $Adapters) {
    $Chains[$Adapter] = [long] ($Chains[$Adapter + 1] + $Chains[$Adapter + 2] + $Chains[$Adapter + 3])
}

$Chains[0]
