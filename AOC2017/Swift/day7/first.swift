import Foundation


func solve(_ input:[String: [String]]) -> String
{
    var seen: Set<String> = Set(input.keys)
    print(seen.count)
    var cnt = 0

    var inner: [String: Int] = Dictionary()
    for (par, val) in input {
        for str in val {
            let v = String(str.dropFirst())
            if !seen.contains(v) {
                if weights[v] != nil {
                    cnt += weights[v]!
                }
                seen.remove(v)
            }
        }
    }

    print(seen.count)
    return seen.popFirst()!
}


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)

var input: [String: [String]] = Dictionary()
var weights: [String: Int] = Dictionary()

for line in content.split(separator: "\n") {
    let second = line.split(separator: "->")
    let key = second[0].split(separator: " ")[0]

    let val: [Substring] =
        if second.count > 1 {
            Array(second[1].split(separator: ","))
        } else { [] }

    input[String(key)] = val.map(String.init)
    weights[String(key)] = Int(line.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
}


print(solve(input))
