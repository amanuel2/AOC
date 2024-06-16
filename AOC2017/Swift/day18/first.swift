import Foundation

func regOrImm(_ str: String, _ vals:[String:Int]) -> Int
{
    if Int(str) == nil { return vals[str]! }
    else  { return Int(str)! } 
}

func solve(_ ops: [String]) -> Int
{
    var last = 0 // last palyed
    var curr = 0 // sound level

    var vals: [String: Int] = [:] // "X":2
    var i = 0

    while i<ops.count {

        let split = ops[i].split(separator: " ").map{String($0)}

        switch split[0] {
            case "snd":
                last = regOrImm(split[1], vals)
            case "set":
                vals[split[1]] = regOrImm(split[2], vals)
            case "add":
                vals[split[1], default:0] += regOrImm(split[2], vals)
            case "mul":
                vals[split[1], default:0] *= regOrImm(split[2], vals)
            case "mod":
                vals[split[1]]! %= regOrImm(split[2], vals)
            case "rcv":
                if vals[split[1]] != nil && vals[split[1]] != 0 { 
                    return last
                }
            case "jgz":
                if vals[split[1]] != nil && vals[split[1]]! > 0 { 
                    i+=regOrImm(split[2], vals) 
                    continue 
                }

            default:
                break
        }

        i+=1
    }

    return 0
}

let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
print(solve(content.split(separator: "\n").map{String($0)}))