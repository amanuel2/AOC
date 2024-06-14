import Foundation

func solve(_ steps: Int) -> Int
{
    var latest = 0
    var cur = 1

    for i in 1...5_000_000 {
        cur = (cur + steps) % i
        cur += 1 // move to the next
        if cur == 1 { latest = i }
    }

    return latest
}


print(solve(344))