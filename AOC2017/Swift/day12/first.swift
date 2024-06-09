import Foundation

func solve(_ mp:[Int:[Int]]) -> Int
{
    var good: [Int] = []
    if mp[0] == nil || mp[0]?.count == 0  { return 0 }

    for n in mp[0]! { good += [n]; }

    var new = false
    while true {
        for g in good {
            for s in mp[g]! { 
                if !good.contains(s) { 
                    new = true
                    good += [s] 
                }
            }
        }

        if !new {break}
        new = false
    }

    return good.count
}

let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
var mp: [Int: [Int]] = [:]

for line in content.split(separator:"\n") {
    let split = line.split(separator: " <-> ")
    let key = Int(String(split[0]))!
    for el in split[1].split(separator:", ") {
        if mp[key] == nil { mp[key] = [] }
        mp[key]! += [Int(el)!]
    }
}

// print(mp)
print(solve(mp))
