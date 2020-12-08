$BootCode = Get-Content -Path 'BootCode.txt'

$LinesExecuted = @()
$Accumulator = 0

$Index = 0

$Change = 1
$Current = 0

while ($true) {
    if ($Index -eq 612) {
        break
    } elseif ($Index -in $LinesExecuted) {
        $LinesExecuted = @()
        $Accumulator = 0
        $Index = 0
        $Current = 0
        $Change += 1
    } else {
        $LinesExecuted += $Index

        $Instruction = $BootCode[$Index]

        $null = $Instruction -match '(?<Operation>\w{3}) (?<Sign>[+|-])(?<Ammount>\d+)'

        $Operation = if ($Matches.Operation -eq 'nop') {
            $Current += 1
            if ($Current -eq $Change) {
                'jmp'
            } else {
                'nop'
            }
        } elseif ($Matches.Operation -eq 'acc') {
            'acc'
        } elseif ($Matches.Operation -eq 'jmp') {
            $Current += 1
            if ($Current -eq $Change) {
                'nop'
            } else {
                'jmp'
            }
        }

        if ($Operation -eq 'nop') {
            $Index += 1
        } elseif ($Operation -eq 'acc') {
            if ($Matches.Sign -eq '+') {
                $Accumulator += [int] $Matches.Ammount
            } else {
                $Accumulator -= [int] $Matches.Ammount
            }
            $Index += 1
        } elseif ($Operation -eq 'jmp') {
            if ($Matches.Sign -eq '+') {
                $Index += [int] $Matches.Ammount
            } else {
                $Index -= [int] $Matches.Ammount
            }
        }
    }
}
