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
        if ($Line -match 'byr:') {
            $byrValue = $true
        }
        if ($Line -match 'iyr:') {
            $iyrValue = $true
        }
        if ($Line -match 'eyr:') {
            $eyrValue = $true
        }
        if ($Line -match 'hgt:') {
            $hgtValue = $true
        }
        if ($Line -match 'hcl:') {
            $hclValue = $true
        }
        if ($Line -match 'ecl:') {
            $eclValue = $true
        }
        if ($Line -match 'pid:') {
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
