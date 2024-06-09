import Foundation

extension String
{
    subscript(idx: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: idx)
        return self[index]
    }
}

func solve(arr: String) -> Int
{
    let inputs: [String.SubSequence] = arr.split(separator: ",")
    var score = 0
    var lvl = 0

    var idx = 0
    var garbage = false
    while idx < arr.count {

        switch arr[idx] {
            case "<":
            if garbage {score+=1}
            garbage = true
            case ">":
            garbage = false
            case "!":
            idx+=1
            default:
            if garbage {score+=1}
        }

        idx+=1
    }

    return score
}


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
print(solve(arr: content))




