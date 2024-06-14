import Foundation

func solve(_ steps: Int) -> Int
{
    var arr = [0,1]
    var cur = 1

    for i in 2...2017 {
        cur = (cur + steps) % arr.count
        cur += 1 // move to the next
        arr.insert(i, at: cur)
    }

    return arr[cur+1]
}


print(solve(344))