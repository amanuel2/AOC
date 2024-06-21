import Foundation

/// day 18 helper
func regOrImm(_ str: String) -> Int
{
    if Int(str) == nil { return regs[str, default:0] }
    else  { return Int(str)! } 
}


func solve(_ ops: [String]) -> Int
{
    var res = 0
    var i = 0
    while i < ops.count {
        let line = ops[i].split(separator: " ").map{String($0)}
        let  (op, x, y) = (line[0], line[1], line[2])
        switch op {
            case "set":
                regs[x] = regOrImm(y)
                break
            case "sub":
                regs[x, default:0] -= regOrImm(y)
                break
            case "mul":
                regs[x, default:0] *= regOrImm(y)
                res+=1
                break
            case "jnz":
                if regs[x] != 0 { i+=regOrImm(y)-1 }
                break
            default:
                fatalError("unrecognized")
        }

        i+=1
        print(i, regs)
    }

    return res
}


var regs: [String:Int] = [:]

for i in 0..<8 {
    regs[String(Character(UnicodeScalar(97 + i)!))] = 0
}

let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
print(solve(content.split(separator: "\n").map{String($0)}))


