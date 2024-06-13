import Foundation


func solve(_ ops: [String], _ dancers: String) -> String
{
    var order = dancers.split(separator: "").map{String($0)}
    for op in ops {
        let sep = op.split(separator: "").map{String($0)}
        switch sep[0] {
            case "s":
                if let spinSize = Int(sep[1...].joined()), spinSize < order.count {
                    let splitIndex = order.count - spinSize
                    order = Array(order[splitIndex...]) + order[0..<splitIndex]
                }
            case "x":
                let sep2 = sep[1...].map{$0}.split(separator: "/")
                let i = Int(sep2[0].map{$0}.joined())!
                let j = Int(sep2[1].map{$0}.joined())!
                order.swapAt(i, j)
            case "p":
                let i = order.firstIndex {$0 == sep[1]}!
                let j = order.firstIndex {$0 == sep[3]}!
                order.swapAt(i, j)
            default: break
        }
    }

    return order.joined()
}

func solve2(_ ops: [String], _ dancers: inout String) -> String
{
    var seen: [String: Int] = [:]
    let org = "abcdefghijklmnop".split(separator: "").map{String($0)}.joined()
    for i in 0..<1_000_000_000 {
        dancers = solve(ops, dancers)
        if let dance = seen[dancers] {
            dancers = org // recycle starting from original config
            let nextIter = 1_000_000_000 % (i-dance)
            for _ in 0..<nextIter { dancers = solve(ops,dancers) }
            break
        }

        seen[dancers]=i
    } 

    return dancers
}

let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
var org = "abcdefghijklmnop".split(separator: "").map{String($0)}.joined()

print(solve2(content.split(separator: ",").map{String($0)}, &org))