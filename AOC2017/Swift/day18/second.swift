import Foundation

func regOrImm(_ str: String, _ vals: [String: Int]) -> Int {
    if let intValue = Int(str) {
        return intValue
    } else if let val = vals[str] {
        return val
    } else {
        return 0
    }
}

func solve(_ line: String, _ idx: inout Int, _ vals: inout [String:Int], _ q: inout [Int], _ otherQ: inout [Int], _ zero: Bool)
{

    
    let split = line.split(separator: " ").map{String($0)}
    switch split[0] {
        case "snd":
            q += [regOrImm(split[1], vals)]
            if !zero {res+=1}
        case "set":
            vals[split[1]] = regOrImm(split[2], vals)
        case "add":
            vals[split[1], default:0] += regOrImm(split[2], vals)
        case "mul":
            vals[split[1], default:0] *= regOrImm(split[2], vals)
        case "mod":
            vals[split[1]]! %= regOrImm(split[2], vals)
        case "rcv":
            if !otherQ.isEmpty { 
                vals[split[1]] = otherQ.removeFirst()
            } else {
                return
            }
        case "jgz":
            if regOrImm(split[1], vals) > 0 {
                idx += regOrImm(split[2], vals) - 1
            }

        default:
            break
    }

    idx+=1
}

let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)

var ops0 = content.split(separator: "\n").map{String($0)}
var ops1 = content.split(separator: "\n").map{String($0)}

var regs0: [String: Int] = ["p": 0]
var regs1: [String: Int] = ["p": 1]


var q0: [Int] = []
var q1: [Int] = []

var idx0 = 0
var idx1 = 0

var res = 0

while idx0 < ops0.count && idx1 < ops1.count {
    let tmp = idx0
    let tmp2 = idx1
    solve(ops0[idx0], &idx0, &regs0, &q0, &q1, true)
    solve(ops1[idx1], &idx1, &regs1, &q1, &q0, false)
    if tmp == idx0 && tmp2 == idx1 { break }
}


print(res)
