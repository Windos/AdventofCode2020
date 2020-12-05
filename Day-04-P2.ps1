$Passports = Get-Content -Path 'Passports.txt'

$byrValue = $false
$iyrValue = $false
$eyrValue = $false
$hgtValue = $false
$hclValue = $false
$eclValue = $false
$pidValue = $false

$ValidCount = 0

foreach ($Line in $Passports) {
    if ($Line -ne '') {
        if ($Line -match 'byr:(?<Year>\d{4})') {
            if ([int] $Matches.Year -ge 1920 -and [int] $Matches.Year -le 2002) {
                $byrValue = $true
            }
        }
        if ($Line -match 'iyr:(?<Year>\d{4})') {
            if ([int] $Matches.Year -ge 2010 -and [int] $Matches.Year -le 2020) {
                $iyrValue = $true
            }
        }
        if ($Line -match 'eyr:(?<Year>\d{4})') {
            if ([int] $Matches.Year -ge 2020 -and [int] $Matches.Year -le 2030) {
                $eyrValue = $true
            }
        }
        if ($Line -match 'hgt:(?<hgt>\d+)(?<unit>cm|in)') {
            if (($Matches.unit -eq 'cm' -and $Matches.hgt -ge 150 -and $Matches.hgt -le 193) -or
                ($Matches.unit -eq 'in' -and $Matches.hgt -ge 59 -and $Matches.hgt -le 76)) {
                    $hgtValue = $true
                }
        }
        if ($Line -match 'hcl:#[0-9a-z]{6}') {
            $hclValue = $true
        }
        if ($Line -match 'ecl:(amb|blu|brn|gry|grn|hzl|oth)') {
            $eclValue = $true
        }
        if ($Line -match 'pid:\d{9}\s') {
            $pidValue = $true
        }
    } else {
        if ($byrValue -and
            $iyrValue -and
            $eyrValue -and
            $hgtValue -and
            $hclValue -and
            $eclValue -and
            $pidValue) {
            $ValidCount += 1
        }

        $byrValue = $false
        $iyrValue = $false
        $eyrValue = $false
        $hgtValue = $false
        $hclValue = $false
        $eclValue = $false
        $pidValue = $false
    }
}

# No blank line at end of file, so double checking the result when no more lines

if ($byrValue -and
    $iyrValue -and
    $eyrValue -and
    $hgtValue -and
    $hclValue -and
    $eclValue -and
    $pidValue) {
    $ValidCount += 1
}

$ValidCount
