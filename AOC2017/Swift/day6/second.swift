import Foundation


func solve(_ arr: inout [Int]) -> Int
{
    var seen: [[Int]: Int] = [:]
    var steps = 0

    while seen[arr] == nil {
        seen[arr] = steps
        let mx = arr.max()!
        let idx = arr.firstIndex(of: mx)!

        arr[idx] = 0
        for i in 1...mx {
            arr[(idx + i) % arr.count] += 1
        }

        steps += 1
    }

    return steps - seen[arr]!
}


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")


let content = try String(contentsOf: inputFileURL, encoding: .utf8)
var arr: [Int] = []
for el in content.split(separator: "\t") {
    arr.append(Int(String(el))!)
}

var test = [0,2,7,0]
print(solve(&arr))









