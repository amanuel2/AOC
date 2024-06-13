import Foundation


func solve(_ ops: [String]) -> String
{
    var order = "abcdefghijklmnop".split(separator: "").map{String($0)}
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


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)

print(solve(content.split(separator: ",").map{String($0)}))