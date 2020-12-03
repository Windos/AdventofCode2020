$Passwords = Get-Content -Path C:\Temp\Passwords.txt

# Part 1

$Count = 0

foreach ($Password in $Passwords) {
    $null = $Password -match '^(?<Min>\d+)-(?<Max>\d+) (?<Letter>\w): (?<Pass>.+)$'

    $LetterCount = $Matches.Pass.ToCharArray().Where({$_ -eq $Matches.Letter}).Count

    if ($LetterCount -ge $Matches.Min -and $LetterCount -le $Matches.Max) {
        $Count += 1
    }
}

$Count

# Part 2

$Count = 0

foreach ($Password in $Passwords) {
    $null = $Password -match '^(?<First>\d+)-(?<Second>\d+) (?<Letter>\w): (?<Pass>.+)$'

    $PassArray = $Matches.Pass.ToCharArray()

    if ($PassArray[$Matches.First - 1] -eq $Matches.Letter -xor $PassArray[$Matches.Second - 1] -eq $Matches.Letter) {
        $Count += 1
    }
}

$Count
