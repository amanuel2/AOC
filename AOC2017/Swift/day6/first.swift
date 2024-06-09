import Foundation


func solve(_ arr: inout [Int]) -> Int
{
    var seen: Set<[Int]> = Set()
    var reps = 0
    
    while(!seen.contains(arr)) {
        seen.insert(arr)
        let mx = arr.max()!
        let idx = arr.firstIndex(of: mx)!

        arr[idx] = 0
        for i in 1...mx {
            arr[(idx + i) % arr.count] += 1
        }

        reps+=1
    }

    return reps
}


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")


let content = try String(contentsOf: inputFileURL, encoding: .utf8)
var arr: [Int] = []
for el in content.split(separator: "\t") {
    arr.append(Int(String(el))!)
}

var test = [0,2,7,0]
print(solve(&arr))





