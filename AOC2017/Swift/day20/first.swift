import Foundation

struct Vector {
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
}

struct Particle {
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

    for _ in 0..<particles.count {
        for i in 0..<particles.count {
            particles[i].update()
        }
    }
    
    return particles.enumerated().min {a,b in 
        a.element.distance() < b.element.distance()
    }?.offset ?? 0
}


let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
print(solve(content))