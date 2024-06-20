import Foundation

typealias MD = [[String]]

struct Matrix {
    var mat: MD

    init(_ mat: MD) { self.mat = mat }

    private func row_reverse(_ m: MD) -> MD {
        return m.map { $0.reversed() }
    }

    private func col_reverse(_ m: MD) -> MD {
        var reversed = m
        for i in 0..<m.count {
            reversed[i] = m[i].reversed()
        }
        return reversed
    }

    private func transpose(_ m: MD) -> MD {
        var transposed = Array(repeating: Array(repeating: "", count: m.count), count: m[0].count)
        for i in 0..<m.count {
            for j in 0..<m[i].count {
                transposed[j][i] = m[i][j]
            }
        }
        return transposed
    }

    func rotate(_ clockwise: Bool = true) -> MD {
        if clockwise { return row_reverse(transpose(mat)) }
        return col_reverse(transpose(mat))
    }

    func flip() -> MD {
        return mat.map { $0.reversed() }
    }

    static func convert(_ str: String) -> MD {
        var res: MD = MD()
        for row in str.split(separator: "/").map { String($0) } {
            res.append(row.map { String($0) })
        }
        return res
    }

    static func ==(lhs: Matrix, rhs: MD) -> Bool {
        if lhs.mat == rhs { return true }
        let transformations = [
            lhs.mat,
            lhs.rotate(),
            Matrix(lhs.rotate()).rotate(),
            Matrix(Matrix(lhs.rotate()).rotate()).rotate(),
            lhs.flip(),
            Matrix(lhs.flip()).rotate(),
            Matrix(Matrix(lhs.flip()).rotate()).rotate(),
            Matrix(Matrix(Matrix(lhs.flip()).rotate()).rotate()).rotate()
        ]

        for transformed in transformations {
            if transformed == rhs { return true }
        }

        return false
    }

    func count() -> Int {
        // new swift compiler just use .count {
        var res = 0
        for i in 0..<mat.count {
            for j in 0..<mat[0].count {
                if mat[i][j] == "#" { res += 1 }
            }
        }
        return res
    }

    mutating func enhance(with rules: [MD: MD]) {
        let sep = (mat.count % 2 == 0) ? 2 : 3
        let size = mat.count / sep
        var newMat: MD = Array(repeating: Array(repeating: "", count: size * (sep + 1)), count: size * (sep + 1))

        for i in 0..<size {
            for j in 0..<size {
                var submatrix: MD = []
                for k in 0..<sep {
                    submatrix.append(Array(mat[i * sep + k][j * sep..<(j * sep + sep)]))
                }

                var transformed: MD = []
                for (key, val) in rules {
                    if Matrix(submatrix) == key {
                        transformed = val
                        break
                    }
                }

                for k in 0..<transformed.count {
                    for l in 0..<transformed[0].count {
                        newMat[i * (sep + 1) + k][j * (sep + 1) + l] = transformed[k][l]
                    }
                }
            }
        }
        self.mat = newMat
    }
}

func solve(_ rules: [MD: MD], _ iter: Int) -> Int {
    var mat: Matrix = Matrix([[".", "#", "."], [".", ".", "#"], ["#", "#", "#"]])

    for _ in 0..<iter {
        mat.enhance(with: rules)
    }

    return mat.count()
}

// Test cases
let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let content = try String(contentsOf: inputFileURL, encoding: .utf8)
let lines = content.split(separator: "\n").map {String($0)}

var mp: [MD:MD] = [MD:MD]()
for line in lines {
    let spl = line.split(separator: " => ").map{String($0)}
    mp[Matrix.convert(spl[0])] = Matrix.convert(spl[1])
}

print(solve(mp, 5))