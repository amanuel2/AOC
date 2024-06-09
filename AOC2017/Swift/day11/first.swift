import Foundation

func solve(_ arr: String) -> Int
{
    var x = 0
    var y = 0
    var mx = Int.min

    for dir in arr.split(separator:",") {
        switch dir {
            case "n": y+=1;
            case "ne": y+=1;x+=1;
            case "nw": x-=1;
            case "s": y-=1;
            case "se": x+=1;
            case "sw": y-=1;x-=1;
            default: break;
        }
        mx = max(mx, max(abs(x), abs(y), abs(x - y)))
    }

    return mx
}


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
print(solve("se,sw,se,sw,sw"))
print(solve(content))

