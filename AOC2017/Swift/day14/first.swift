import Foundation

/// Day 10
func reverse(_ arr:inout [Int], _ startidx: Int, _ length: Int)
{
    var i = startidx
    var j = (startidx + length - 1)

    while i < j {
        arr.swapAt(i % arr.count, j % arr.count)
        i += 1
        j -= 1
    }
}

func knotHash(_ input: String) -> String
{
    var lengths = input.utf8CString.map {Int($0)}
    lengths.append(contentsOf: [17, 31, 73, 47, 23])
    var a = Array(0..<256)
    var skip = 0
    var idx = 0

    for _ in 0..<64 {
        for length in lengths {
            if length > a.count {continue}
            reverse(&a, idx, length)
            idx += (skip+length)
            idx %= a.count
            skip += 1
        }
    }

    var dense = [Int]()
 
    // for i in 0..<16 {
    //     let slice = a[i*16..<(i+1)*16]
    //     dense.append(slice.reduce(0, ^))
    // }

    for i in stride(from: 0, to: 256, by: 16){
        var xd = a[i]
        for j in i+1..<i+16 {
            xd ^= a[j]
        }
        dense.append(xd)
    }

    return dense.map {String(format: "%02x", $0)}.joined()
}
/////

func ascii_bin(_ str: String) -> String
{
    // let conv = str.map{Int(String($0), radix:16)!} .map {Int($0)}
    // return conv.map { String($0, radix:2) }.map{$0.padding(toLength: 4, withPad:"0", startingAt: 0)} .joined()
    return str.map { 
        String(Int(String($0), radix: 16)!, radix: 2).padding(toLength: 8, withPad: "0", startingAt: 0) 
    }.joined()
}

func solve(_ str: String) -> Int
{
    var res = 0
    for i in 0..<128 { 
        let hash = knotHash("\(str)-\(i)")
        res += ascii_bin(hash).count {$0=="1"} 
    }
    return res
}



let input = "uugsqrei"
print(solve(input))
