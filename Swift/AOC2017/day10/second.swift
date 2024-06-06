import Foundation

func reverse(_ arr:inout [Int], _ startidx: Int, _ length: Int)
{
    var i = startidx
    var j = ((i + length - 1) % arr.count)
    // var steps = 0 // elements reversed


    for _ in 0..<(length/2) {
        arr.swapAt(i, j)
        i = ((i + 1) % arr.count)
        j = ((j - 1) % arr.count)
        if j<0 {j = arr.count-1}
    }
}

func solve(_ arr: inout [Int], _ lengths: [Int]) -> String
{
    var skip = 0
    var idx = 0

    for _ in 0..<64 {
        for length: Int in lengths {
            if length > arr.count {continue}
            reverse(&arr, idx, length)
            idx = (idx + skip + length) % arr.count
            skip += 1
        }
    }

    var hash: [Int] = []
    for i in stride(from: 0, to: arr.count, by: 16) {
        var res = 0
        for j in i..<min(i+16, arr.count) {
            res ^= arr[j]
        }
        hash.append(res)
    }

    var hex: [String] = []
    for num in hash {
        hex.append(String(format: "%02x", num))
    }

    return hex.joined()
}

let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
var lengths = content.utf8.map { Int($0) }
lengths.append(contentsOf: [17, 31, 73, 47, 23])

var b = Array(0..<256)
print(solve(&b, lengths))

// print(solve(&a, lengths))
