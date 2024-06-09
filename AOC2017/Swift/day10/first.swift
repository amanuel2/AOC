import Foundation

func reverse(_ arr:inout [Int], _ startidx: Int, _ length: Int)
{
    var i = startidx
    var j = ((i + length) % arr.count) - 1
    // var steps = 0 // elements reversed


    for _ in 0..<(length/2) {
        arr.swapAt(i, j)
        i = ((i + 1) % arr.count)
        j = ((j - 1) % arr.count)
        if j<0 {j = arr.count-1}
    }
}

func solve(_ arr: inout [Int], _ lengths: [Int]) -> Int
{
    var skip = 0
    var idx = 0

    for length in lengths {
        if length > arr.count {continue}
        reverse(&arr, idx, length)
        idx += (skip+length)
        idx %= arr.count
        skip += 1
    }

    return arr[0] * arr[1]
}

var a = [0,1,2,3,4]
var lengths = [3,4,1,5]

let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8).split(separator: ",").map{Int($0)!}
// print(content)
var b = Array(0..<256)
print(solve(&b, content))

// print(solve(&a, lengths))
