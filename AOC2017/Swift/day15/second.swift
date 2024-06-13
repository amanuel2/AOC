import Foundation

func solve() -> Int
{
    let p1a = sequence(first: 65, next: { ($0 * 16807) % 2147483647 }).prefix(5_000_000)
    let p1b = sequence(first: 8921, next: { ($0 * 48271) % 2147483647 }).prefix(5_000_000)

    var p2 = p1a.filter {$0%4==0}.makeIterator()
    var p3 = p1b.filter {$0%8==0}.makeIterator()

    return (0..<5_000_000).reduce (0) {acc,_ in 
        acc + (p2.next()! & 0xFFFF == p3.next()! & 0xFFFF ? 1 : 0)
    }
}

print(solve())