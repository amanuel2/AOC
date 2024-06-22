import Foundation
import Swift

// struct Port
// {
//     var x,y
//     init(_ x: Int, _ y: Int) { self.x = x; self.y = y; }
// }

// fuck this......
func solve(_ last: Int, _ ports: [(Int, Int)], _ curr: Int)
{
    print(ports.count)
    if ports.count == 0 { 
        return 
    }

    for i in 0..<ports.count {
        let port = ports[i]
        var remainingPorts = ports
        remainingPorts.remove(at:remainingPorts.firstIndex{$0.0 == port.0 && $0.1 == port.1}!)
        if last == port.0 {
            solve(port.1, remainingPorts, curr + port.0 + port.1)
        } else if last == port.1 {
            solve(port.0, remainingPorts, curr + port.0 + port.1)
        }
        res = max(res, curr)
    }
}

var res = 0
let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
let lines = content.split(separator: "\n").map{String($0)}
let tupes = lines.map { line in
    var l = line.split(separator: "/").map{String($0)}
    return (Int(l[0])!, Int(l[1])!)
}

print(tupes)
solve(0, tupes , 0)
print(res)