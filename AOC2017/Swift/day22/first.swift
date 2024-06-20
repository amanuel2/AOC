import Foundation

struct Coordinate: Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
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

func solve(_ infected: inout Set<Coordinate>, _ m: Int, _ n: Int) -> Int {
    var player = Player(m / 2, n / 2)
    var res = 0


    for i in 0..<10_000 {
        let currentPos = Coordinate(player.x, player.y)
        if i < 10 {
            print("infected \(infected)")
            print("current pos \(currentPos)")
            print("contains \(infected.contains(currentPos))")
        }
        if infected.contains(currentPos) {
            player.turn(false) // turn right
            infected.remove(currentPos)
        } else {
            player.turn(true) // turn left
            infected.insert(currentPos)
            res += 1
        }
        if i < 10 { print("face \(player.face)") }
        player.move()

        // Debugging statements
        if i < 10 {  // Print first 10 steps for debugging
            print("Step \(i + 1):")
            print("  Player position: (\(player.x), \(player.y))")
            print("  Player direction: \(player.face)")
            print("  Infection count: \(res)")
            print("infected \(infected)")
            print("--------------------")
        }
    }

    return res
}

let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)

var infected: Set<Coordinate> = Set()
var lines = content.split(separator: "\n").map { String($0) }

for (i, line) in lines.enumerated() {
    for (j, ch) in line.enumerated() {
        if ch == "#" { infected.insert(Coordinate(i, j)) }
    }
}

// infected = [Coordinate(1,0), Coordinate(0,2)]

// print(solve(&infected, 3, 3))

print(solve(&infected, lines.count, lines[0].count))



