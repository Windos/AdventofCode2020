$BootCode = Get-Content -Path 'BootCode.txt'

$LinesExecuted = @()
$Accumulator = 0

$Index = 0

while ($true) {
    if ($Index -in $LinesExecuted) {
        break
    } else {
        $LinesExecuted += $Index

        $Instruction = $BootCode[$Index]

        $null = $Instruction -match '(?<Operation>\w{3}) (?<Sign>[+|-])(?<Ammount>\d+)'

        if ($Matches.Operation -eq 'nop') {
            $Index += 1
        } elseif ($Matches.Operation -eq 'acc') {
            if ($Matches.Sign -eq '+') {
                $Accumulator += [int] $Matches.Ammount
            } else {
                $Accumulator -= [int] $Matches.Ammount
            }
            $Index += 1
        } elseif ($Matches.Operation -eq 'jmp') {
            if ($Matches.Sign -eq '+') {
                $Index += [int] $Matches.Ammount
            } else {
                $Index -= [int] $Matches.Ammount
            }
        }
    }
}
