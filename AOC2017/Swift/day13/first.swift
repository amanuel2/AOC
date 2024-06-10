import Foundation

enum DIR
{
    case UP, DOWN
}


func advance(_ arr: [Int:Int], _ pos: inout [Int:(Int,DIR)])
{
    for mp in arr
    {
        let curr = mp.key
        let rng = mp.value - 1
        if pos[curr]?.1 == DIR.DOWN {
            if pos[curr]!.0 - 1 < 0 {
                pos[curr]!.1 = DIR.UP
                pos[curr]!.0+=1
            } else { pos[curr]!.0-=1 }
        } else {
            if pos[curr]!.0 + 1 > rng {
                pos[curr]!.1 = DIR.DOWN
                pos[curr]!.0-=1
            } else { pos[curr]!.0+=1 }
        }
    }
}

func solve(_ arr: [Int:Int]) -> Int
{
    // column : range_pos
    var pos: [Int: (Int, DIR)] = [:]
    for v in arr { pos[v.key] = (0, DIR.DOWN) }
    var pen = 0

    // picoseconds
    let maxKey = arr.keys.max() ?? 0

    for cur in 0...maxKey {
        if pos[cur]?.0 == 0 { pen += (cur*arr[cur]!) }
        advance(arr, &pos)
    }

    return pen
}


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
var mp: [Int: Int] = [:]

for line in content.split(separator:"\n") {
    let split = line.split(separator: ": ")
    mp[Int(split[0])!] = Int(split[1])!
}

print(solve(mp))