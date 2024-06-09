import Foundation



func solve(_ arr: inout [Int]) -> Int
{
    var curr = 0;
    var steps = 0

    while (curr<arr.count && curr>=0) {
        let prev = curr
        curr+=arr[curr]
        arr[prev]+=1

        steps+=1
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