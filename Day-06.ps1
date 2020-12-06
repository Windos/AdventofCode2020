$DeclarationForms = 'Declarations.txt'

# Part 1

$CurrentDeclaration = ''
$SumOfCounts = 0

foreach ($Index in 0..$DeclarationForms.Length) {
    if ($DeclarationForms[$Index] -ne '' -and $null -ne $DeclarationForms[$Index]) {
        $CurrentDeclaration += $DeclarationForms[$Index]
    } else {
        $SumOfCounts += ($CurrentDeclaration.ToCharArray() | Select-Object -Unique).Count
        $CurrentDeclaration = ''
    }
}

$SumOfCounts

# Part 2

$CurrentDeclaration = @()
$SumOfCounts = 0

foreach ($Index in 0..$DeclarationForms.Length) {
    if ($DeclarationForms[$Index] -ne '' -and $null -ne $DeclarationForms[$Index]) {
        $CurrentDeclaration += $DeclarationForms[$Index]
    } else {
        if ($CurrentDeclaration.Count -eq 1) {
            $SumOfCounts += ($CurrentDeclaration[0].ToCharArray() | Select-Object -Unique).Count
        } else {
            $RunningGroup = $CurrentDeclaration[0].ToCharArray()
            foreach ($SubIndex in 1..($CurrentDeclaration.Count - 1)) {
                if ($RunningGroup) {
                    $RunningGroup = Compare-Object $RunningGroup $CurrentDeclaration[$SubIndex].ToCharArray() -IncludeEqual -ExcludeDifferent -PassThru
                }
            }
            $SumOfCounts += ($RunningGroup).Count
        }
        $CurrentDeclaration = @()
    }
}

$SumOfCounts
