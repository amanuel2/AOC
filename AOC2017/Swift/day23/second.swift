import Foundation
import Swift

/// day 18 helper
func regOrImm(_ str: String) -> Int
{
    if str=="c" {return -73700}
    if Int(str) == nil { return regs[str, default:0] }
    else  { return Int(str)! } 
}

// func coalese(_ inst: Int)
// {
//     switch (inst)
//     {
//         case 0:
//             regs["e"]
//     }
// }

// sieve of eiro
func isprime(_ n: Int) -> Bool
{
    if n%2 == 0 {return false}
    for i in stride(from:3, to:sqrt(Double(n))+1, by:2) {
        if n % Int(i) == 0 {return false}
    }
    return true
}

func solve(_ ops: [String]) -> Int
{
    var res = 0
    var i = 0
    while i < ops.count {
        let line = ops[i].split(separator: " ").map{String($0)}
        let  (op, x, y) = (line[0], line[1], line[2])
        
        if i == 0 { i+=1; continue; }
        if i == 1 {
            regs["g"] = 2*regs["d"]!;
            continue;
        }
        if op == "mul" { mul+=1 }

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
                // if regs[x] != 0 { i+=regOrImm(y)-1 }
                if !isprime(regOrImm(x)) { i+=Int(y)!-1 }
                break
            default:
                fatalError("unrecognized")
        }
    }

    i+=1

    return regs["h", default:0]
}


var regs: [String:Int] = [:]

for i in 0..<8 {
    regs[String(Character(UnicodeScalar(97 + i)!))] = 0
}
regs["a"] = 1
regs["b"] = -90700
regs["c"] = -73700
regs["f"] = 1
regs["d"] = 2

let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input2.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
print(solve(content.split(separator: "\n").map{String($0)}))


