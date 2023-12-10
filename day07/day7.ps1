function Get-HandRank ($hand) {
    function Get-Wildcard-Rank {
        param (
            [string]$wildcardHand
        )

        $wildcardCharacters = $wildcardHand.ToCharArray()
        $wildcardCharCounts = $wildcardCharacters | Group-Object -NoElement | ForEach-Object { $_.Count }

        if ($wildcardCharCounts -contains 5) {
            return 1
        }
        elseif ($wildcardCharCounts -contains 4) {
            return 2
        }
        elseif ($wildcardCharCounts -contains 3 -and $wildcardCharCounts -contains 2) {
            return 3
        }
        elseif ($wildcardCharCounts -contains 3) {
            return 4
        }
        elseif (($wildcardCharCounts | Where-Object { $_ -eq 2 } | Measure-Object).Count -eq 2) {
            return 5
        }
        elseif ($wildcardCharCounts -contains 2) {
            return 6
        }
        return 7
    }

    $wildcardRanks = @()
    foreach ($card in $order.Keys) {
        $wildcardHand = $hand -replace 'J', $card
        $wildcardRanks += Get-Wildcard-Rank $wildcardHand
    }

    $rank = $wildcardRanks | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum

    return $rank
}

$order = @{
    '2' = 1
    '3' = 2
    '4' = 3
    '5' = 4
    '6' = 5
    '7' = 6
    '8' = 7
    '9' = 8
    'T' = 9
    'J' = 0
    'Q' = 999
    'K' = 9999
    'A' = 99999
}

$inputFile = "input.txt"
$inputData = Get-Content $inputFile

$lines = $inputData -split "`n"
$handList = @()

foreach ($line in $lines) {
    $hand, $bid = $line -split ' '
    $rank = Get-HandRank $hand

    $handList += [PSCustomObject]@{
        Hand = $hand
        Bid  = $bid
        Rank = $rank
    }
}
$sortedHandList = $handList | Sort-Object -Property Rank, @{Expression = { $_.'Hand' -split '' | ForEach-Object { $order[$_] } }; Ascending = $false }
$sortedHandList | Format-Table -AutoSize -Wrap
$sum = 0

foreach ($i in 0..($sortedHandList.Count - 1)) {
    $sum += + $sortedHandList[$i].Bid * (($sortedHandList.Count - $i))
}
Write-Output $sum



Set-ExecutionPolicy RemoteSigned -Scope Process