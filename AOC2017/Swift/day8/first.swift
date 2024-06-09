import Foundation

func solve(_ arr:String) -> Int
{
    let lines = arr.split(separator: "\n")
    var registers: [String:Int] = [:]

    for line in lines {
        let components = line.split(separator: " ")
        let register = String(components[0])
        let operation = components[1] == "inc" ? +1 : -1
        let amount = Int(components[2])! * operation
        let conditionRegister = String(components[4])
        let conditionOperator = components[5]
        let conditionValue = Int(components[6])!

        print(conditionRegister, conditionOperator, conditionValue, registers)
        if check(conditionRegister, String(conditionOperator), conditionValue, registers) {
            registers[register, default: 0] += amount
        }
    }

    print(registers)
    return registers.values.max() ?? 0
}

func check(_ reg: String, _ op: String, _ val: Int, _ registers: [String:Int]) -> Bool
{
    let reg_val = registers[reg] ?? 0
    switch op {
        case ">":
            return reg_val > val
        case "<":
            return reg_val < val
        case ">=":
            return reg_val >= val
        case "<=":
            return reg_val <= val
        case "==":
            return reg_val == val
        case "!=":
            return reg_val != val
        default:
            return false
    }
}


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
print(solve(content))