import Foundation

typealias MD = [[String]]

struct Matrix
{
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

    // static func ==(lhs: Matrix, rhs: MD) -> MD?
    // {
    //     if lhs.mat == rhs { return rhs }
    //     // if lhs.flip() == rhs { return rhs }
    //     if lhs.rotate() == rhs { return rhs }
    //     if Matrix(lhs.rotate()).rotate() == rhs { return rhs }
    //     if Matrix(Matrix(lhs.rotate()).rotate()).rotate() == rhs { return rhs }
    //     return nil
    // }

    static func ==(lhs: Matrix, rhs: MD) -> MD? {
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
            if transformed == rhs { return rhs }
        }

        return nil
    }
    

    func count() -> Int
    {
        // don't have updated compiler for .count(where: ), fudge
        var res = 0
        for i in 0..<mat.count {
            for j in 0..<mat[0].count {
                if mat[i][j] == "#" { res += 1 }
            }
        }
        return res
    }

    mutating func dim()
    {
        if mat.count == 2 || mat.count == 3 { return }
        var sep = -1

        if (mat.count % 2) == 0  { sep = 2 }
        else if (mat.count % 3) == 0 { sep = 3 }
        else { fatalError("Non 2/3 divisbile mat") }


        var res: MD = MD()
        // TODO: for some reason going after 4 here, and gives AOB
        for i in stride(from: 0, through: mat.count, by: sep) {
            for j in stride(from: 0, through: mat.count, by: sep) {
                var submatrix: MD = []
                for k in i..<i+sep {
                    submatrix.append(Array(mat[k][j..<j+sep]))
                }
                res.append(contentsOf: submatrix)
            }
        }

        // it has appended in columns first then finish then next row
        // this might not be correct
        self.mat = res
    }
}


// flip = two rotates

// func solve(_ rules: [MD: MD]) -> Int
// {
//     var mat: Matrix = Matrix([[".", "#", "."], [".", ".", "#"], ["#", "#", "#"]])

//     var changed = false
//     var i = 0

//     repeat {
//         for rule in rules {
//             let (key,val) = rule
//             if let _ = mat == key {
//                 mat = Matrix(val)
//                 changed = true
//                 break
//             } else if let _ = Matrix(mat.flip()) == key {
//                 mat = Matrix(val)
//                 changed = true
//                 break
//             }
//         }
//         i+=1
//     } while(changed && i<5)

//     return mat.count()
// }

func solve(_ rules: [MD: MD]) -> Int {
    var mat: Matrix = Matrix([[".", "#", "."], [".", ".", "#"], ["#", "#", "#"]])
    var changed = false
    var i = 0

    repeat {
        changed = false
        mat.dim()
        for rule in rules {
            let (key, val) = rule
            if let _ = mat == key {
                mat = Matrix(val)
                changed = true
                break
            }
        }
        i += 1
    } while changed && i < 2

    return mat.count()
}


// let inputFileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
// let content = try String(contentsOf: inputFileURL, encoding: .utf8)

// let lines = content.split(separator: "\n").map {String($0)} // .split(separator: " => ")
let lines = ["../.# => ##./#../...", ".#./..#/### => #..#/..../..../#..#"]

var mp: [MD:MD] = [MD:MD]()
for line in lines {
    let spl = line.split(separator: " => ").map{String($0)}
    mp[Matrix.convert(spl[0])] = Matrix.convert(spl[1])
}

print(solve(mp))
