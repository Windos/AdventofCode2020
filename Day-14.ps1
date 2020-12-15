$Bitmasks = Get-Content -Path C:\Temp\Bitmasks.txt

# Part 1

$Values = @{}

foreach ($Line in $Bitmasks) {
    if ($Line -match 'mask = (?<Mask>.+)') {
        $Mask = $Matches.Mask
    } else {
        $null = $Line -match 'mem\[(?<Mem>\d+)\] = (?<Number>\d+)'
        $Number = [System.Convert]::ToString($Matches.Number,2).PadLeft(36,'0').ToCharArray()

        foreach ($Position in 0..($Mask.Length - 1)) {
            if ($Mask[$Position] -ne 'X') {
                if ($Mask[$Position] -eq '0') {
                    $Number[$Position] = '0'
                } elseif ($Mask[$Position] -eq '1') {
                    $Number[$Position] = '1'
                }
            }
        }

        $Values[$Matches.Mem] = [System.Convert]::ToUInt64($Number -join '',2)
    }
}

($Values.Values | Measure-Object -Sum).Sum

# Part 2
# Credit for solution: https://old.reddit.com/r/PowerShell/comments/kd2x5a/advent_of_code_2020_day_14_docking_data/gfu1q7x/

$Values = @{}

foreach ($Line in $Bitmasks) {
    if ($Line -match 'mask = (?<Mask>.+)') {
        $Mask = $Matches.Mask
        $xMask = $Matches.Mask.Replace('1', '0').Replace('X', '1')
    } else {
        $null = $Line -match 'mem\[(?<Mem>\d+)\] = (?<Number>\d+)'

        [uint64] $Mem = $Matches.Mem
        [uint64] $Num = $Matches.Number

        $MemChars = [System.Convert]::ToString($Mem, 2).PadLeft(36, '0').ToCharArray()

        foreach ($Index in 0..($Mask.Length - 1)){
            if ($Mask[$Index] -eq '1') {
                $MemChars[$Index] = '1'
            }
        }

        $strMem = $MemChars -join ''

        $xMaskNoOnes = $xMask.Replace('0', '')
        $MaxIndex = [System.Convert]::ToInt32($xMaskNoOnes, 2)

        foreach ($Index in 0..$MaxIndex) {
            $StringNoOnes = [System.Convert]::ToString($Index, 2).padleft($xMaskNoOnes.length, '0')
            $Offset = 0

            $Result = foreach ($SubIndex in 0..($Mask.Length - 1)) {
                if ($Mask.Substring($SubIndex, 1) -eq 'X') {
                    $StringNoOnes.Substring($Offset, 1)
                    $Offset += 1
                } else {
                    $strMem.Substring($SubIndex, 1)
                }
            }

            $ResultString = $Result -join ''
            $Values[$ResultString] = $Num
        }
    }
}

($Values.Values | Measure-Object -Sum).Sum
