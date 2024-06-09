import Foundation

func prev(_ mp:[Int: [Int]], _ num: Int) -> [Int]
{
    var good: [Int] = []
    if mp[num] == nil || mp[num]?.count == 0  { return [] }

    for n in mp[num]! { good += [n]; }

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

    return good
}

func solve(_ mp:[Int:[Int]]) -> Int
{
    var all: [Int: [Int]] = [:]
    for key in mp.keys {
        all[key] = prev(mp, key)
    }

    var groups = 0
    var seen: Set<Int> = []
    // keys sorted by highest count() on value
    let keys_sorted = all.map{$0.key}.sorted(by: { all[$0]!.count > all[$1]!.count })
    for key in keys_sorted {
        var tmp: Set<Int> = []
        if seen.contains(key) { continue }
        for v in all[key]! {
            if seen.contains(v) { continue }
            tmp.insert(v)    
        }

        tmp.insert(key)
        seen = seen.union(tmp)
        groups+=1
    }

    return groups
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
