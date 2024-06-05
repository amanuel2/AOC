import Foundation

func bounds(_ arr: [Int], _ idx: Int) -> Bool
{
    return idx>=0 && idx<arr.count
}

func solve(_ arr: inout [Int]) -> Int
{
    var curr = 0;
    var steps = 0

    while (bounds(arr,curr)) {
        let jump = arr[curr]
        if jump >= 3 {
            arr[curr] -= 1
        } else {
            arr[curr] += 1
        }
        curr += jump
        steps += 1
    }

    return steps
}


let sourceFileURL = URL(fileURLWithPath: #file)
let inputFileURL = sourceFileURL.deletingLastPathComponent().appendingPathComponent("input.txt")

do {
    let content = try String(contentsOf: inputFileURL, encoding: .utf8)
    var arr: [Int] = []
    for el in content.split(separator: "\n") {
        arr.append(Int(String(el))!)
    }
    print(solve(&arr))
} catch {
    print("Error reading file: \(error)")
}