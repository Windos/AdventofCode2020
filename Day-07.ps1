$BagRules = Get-Content -Path 'BagRules.txt'

# Part 1

$CompiledBagRules = foreach ($Rule in $BagRules) {
    $null = $Rule -match '(?<Parent>[\w\s]+) bags contain [\d]+ (?<Child>.+).'

    [PSCustomObject] [Ordered] @{
        Parent = $Matches.Parent
        Children = ($Matches.Child -split ', [\d] ') -replace ' (?:bags|bag)', ''
    }
}

$BagsChecked = @()
$BagSearch = @(,'shiny gold')
$Count = 0

while ($BagSearch.Count -gt 0) {
    $NextSearch = @()

    foreach ($Bag in $BagSearch) {
        $CompiledBagRules | Where-Object {$_.Children -contains $Bag} | ForEach-Object {
            if ($_.Parent -notin $BagsChecked) {
                $BagsChecked += $_.Parent
                $NextSearch += $_.Parent
                $Count += 1
            }
        }
    }

    $BagSearch = $NextSearch
}

$Count

# Part 2

function Search-Bag {
    param (
        $BagToSearch
    )

    $Count = 0

    foreach ($Child in $BagToSearch.Children) {
        if ($Child -match '(?<Amount>\d+) (?<Name>.+)') {
            $Amount = [int] $Matches.Amount
            $Name = $Matches.Name

            $Count += $Amount

            $BagObject = $CompiledBagRules | Where-Object {$_.Parent -eq $Name}

            foreach ($Bag in $BagObject) {
                if ($Bag.Children -ne 'no other') {
                    $Count += $Amount * (Search-Bag -BagToSearch $Bag)
                }
            }
        }
    }

    $Count
}

$CompiledBagRules = foreach ($Rule in $BagRules) {
    $null = $Rule -match '(?<Parent>[\w\s]+) bags contain (?<Child>.+).'

    [PSCustomObject] [Ordered] @{
        Parent = $Matches.Parent
        Children = ($Matches.Child -split ', ') -replace ' (?:bags|bag)', ''
    }
}

$ShinyGold = $CompiledBagRules | Where-Object {$_.Parent -eq 'shiny gold'}
Search-Bag -BagToSearch $ShinyGold
