import Foundation

func next(_ lines: [[String]], _ curr: (Int,Int), _ prev: (Int, Int)) -> (Int, Int)
{
    let vx = curr.0-prev.0, vy = curr.1-prev.1
    switch lines[curr.0][curr.1] {
        case "|":
            return (curr.0+vx, curr.1+vy)
        case "-":
            return (curr.0+vx, curr.1+vy)
        case "+":
            for (i,j) in [(0,1),(1,0),(-1,0),(0,-1)] {
                let ni = curr.0 + i
                let nj = curr.1 + j
                if (ni, nj) != prev && ni >= 0 && ni < lines.count && nj >= 0 && nj < lines[0].count && lines[ni][nj] != " " {
                    return (ni, nj)
                }
            }
        default:
            return (curr.0+vx, curr.1+vy)
    }

    fatalError("Invalid input")
}

func solve(_ lines: [[String]]) -> String
{
    var res = ""
    var i = 0 ,j=0

    for k in 0..<lines[i].count {
        if lines[i][k] != " " {
            j = k
            break
        }
    }

    var prevI = -1, prevJ = j
    while true {
        switch lines[i][j] {
            case "|", "-", "+":
                let nextPos = next(lines, (i,j), (prevI, prevJ))
                prevI = i
                prevJ = j
                i = nextPos.0
                j = nextPos.1
            default:
                res += lines[i][j]
                let nextPos = next(lines, (i,j), (prevI, prevJ))
                prevI = i
                prevJ = j
                i = nextPos.0
                j = nextPos.1
        }
        
        loopies += 1
        // Bounds checking
        if i < 0 || j < 0 || i >= lines.count || j >= lines[0].count || lines[i][j] == " " || (prevI,prevJ)==(i,j) {
            break
        }
    }

    return res
}


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
let lines = content.split(separator: "\n").map { $0.split(separator: "").map {String($0)} }
var loopies = 0
print(solve(lines))
print("we did \(loopies) loops")
