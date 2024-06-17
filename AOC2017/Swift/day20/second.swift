import Foundation

struct Vector: Hashable {
    var x: Int
    var y: Int
    var z: Int

    init() {
        self.x = 0
        self.y = 0
        self.z = 0
    }

    init(_ arr: [String]) {
        self.x = Int(arr[0])!
        self.y = Int(arr[1])!
        self.z = Int(arr[2])!
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }    
}

struct Particle: Hashable {
    var p: Vector
    var v: Vector
    var a: Vector

    init(_ p: Vector, _ v: Vector, _ a: Vector) {
        self.p = p
        self.v = v
        self.a = a
    }

    func distance() -> Int {
        return abs(p.x) + abs(p.y) + abs(p.z)
    }

    mutating func update() {
        v.x += a.x
        v.y += a.y
        v.z += a.z

        p.x += v.x
        p.y += v.y
        p.z += v.z
    }

    func updateCheck() -> Vector {
        return Vector(
            [String(p.x + (v.x + a.x)),
             String(p.y + (v.y + a.y)),
             String(p.z + (v.z + a.z))]
        )
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(p)
    }

    static func == (lhs: Particle, rhs: Particle) -> Bool {
        return lhs.p == rhs.p
    }
}


func solve(_ str: String) -> Int
{

    var particles: [Particle] = [Particle]()
    for line in str.split(separator: "\n") {
        var particle = Particle(Vector(),Vector(),Vector())
        let commas = line.split(separator: ", ").map { String($0) }
        
        let ps = commas[0].split(separator: "=")[1].trimmingCharacters(in: CharacterSet(charactersIn: "<>")).split(separator: ",").map{String($0)}
        particle.p = Vector(ps)

        let vs = commas[1].split(separator: "=")[1].trimmingCharacters(in: CharacterSet(charactersIn: "<>")).split(separator: ",").map{String($0)}
        particle.v = Vector(vs)

        let a = commas[2].split(separator: "=")[1].trimmingCharacters(in: CharacterSet(charactersIn: "<>")).split(separator: ",").map{String($0)}
        particle.a = Vector(a)

        particles.append(particle)
    }
    
    for _ in 0..<1000 {
        var positions: [Vector: [Int]] = [:]

        for (idx,val) in particles.enumerated() { 
            positions[val.updateCheck(), default: []].append(idx)
        }

        var toRemove: Set<Int> = []
        for (_, indices) in positions where indices.count > 1 {
            toRemove.formUnion(indices)
        }

        if toRemove.isEmpty {
            for i in 0..<particles.count { particles[i].update() }
        } else {
            for index in toRemove.sorted(by: >) { particles.remove(at: index) }
        }
    }
    
    return particles.count
}


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
print(solve(content))