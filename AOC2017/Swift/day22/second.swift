import Foundation

struct Coordinate: Hashable {
    let x: Int
    let y: Int
    var state: State
    
    init(_ x: Int, _ y: Int, _ state: State = .Clean) {
        self.x = x
        self.y = y
        self.state = state
    }
}

extension Set where Element == Coordinate {
    func contains(_ coord: Coordinate) -> Bool {
        return self.contains { $0.x == coord.x && $0.y == coord.y }
    }
}

enum Direction {
    case left, right, down, up
}

enum State
{
    case Clean, Weakened, Infected, Flagged
}

struct Player {
    var face: Direction
    var x: Int, y: Int
    init(_ x: Int, _ y: Int) { face = .up; self.x = x; self.y = y; }

    mutating func turn(_ left: Bool) {
        switch face {
        case .left: face = left ? .down : .up
        case .right: face = left ? .up : .down
        case .up: face = left ? .left : .right
        case .down: face = left ? .right : .left
        }
    }

    mutating func move() {
        switch face {
        case .left: self.y -= 1
        case .right: self.y += 1
        case .down: self.x += 1
        case .up: self.x -= 1
        }
    }
}

func solve(_ mutated: inout Set<Coordinate>, _ m: Int, _ n: Int) -> Int {
    var player = Player(m / 2, n / 2)
    var res = 0


    for i in 0..<10_000_000 {
        let currentPos = Coordinate(player.x, player.y)
        if i < 10 {
            print("mutated \(mutated)")
            print("current pos \(currentPos)")
            print("contains \(mutated.contains(currentPos))")
        }

        if let p = mutated.first(where: { $0.x == currentPos.x && $0.y == currentPos.y }) {
            switch p.state {
                case .Clean:
                    player.turn(true)
                    mutated.remove(p)
                    mutated.insert(Coordinate(p.x, p.y, .Weakened))
                case .Weakened:
                    mutated.remove(p)
                    mutated.insert(Coordinate(p.x, p.y, .Infected))
                case .Infected:
                    player.turn(false)
                    mutated.remove(p)
                    mutated.insert(Coordinate(p.x, p.y, .Flagged))
                    res+=1
                case .Flagged:
                    player.turn(true); player.turn(true);
                    mutated.remove(p)
                    mutated.insert(Coordinate(p.x, p.y, .Clean))
            }

            player.move()
        } else {
            print("WHAT \(currentPos.x), \(currentPos.y)")
            mutated.insert(Coordinate(currentPos.x, currentPos.y, .Weakened))
        }

        // Debugging statements
        if i < 10 {  // Print first 10 steps for debugging
            print("Step \(i + 1):")
            print("  Player position: (\(player.x), \(player.y))")
            print("  Player direction: \(player.face)")
            print("  Infection count: \(res)")
            print("mutated \(mutated)")
            print("--------------------")
        }
    }

    return res
}

let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)

var mutated: Set<Coordinate> = Set()
var lines = content.split(separator: "\n").map { String($0) }

for (i, line) in lines.enumerated() {
    for (j, ch) in line.enumerated() {

        if ch == "#" { mutated.insert(Coordinate(i, j, .Infected)) }
        else { mutated.insert(Coordinate(i, j, .Clean))}
    }
}

// mutated = [Coordinate(1,0), Coordinate(0,2)]

// print(solve(&mutated, 3, 3))

print(solve(&mutated, lines.count, lines[0].count))



