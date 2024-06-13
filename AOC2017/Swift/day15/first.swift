import Foundation



func solve(_ pairs: Int) -> Int
{
    var genA = [65]
    var genB = [8921]

    for _ in 0...pairs {
        genA.append((genA.last!*16807) % 2147483647)
        genB.append((genB.last!*48271) % 2147483647)
    }

    var res = 0
    let binA = genA.map {String($0, radix:2)}
    let binB = genB.map {String($0, radix: 2)}
    for (a,b) in zip(binA, binB) {
        let startA = a.index(a.endIndex, offsetBy: -min(a.count, 16))
        let startB = b.index(b.endIndex, offsetBy: -min(b.count, 16))
        if a[startA...] == b[startB...] { res += 1 }
    }

    return res
}

print(solve(40_000_000))