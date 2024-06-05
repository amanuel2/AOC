    var inner: [String: Int] = Dictionary()
    for (par, val) in input {
        for str in val {
            let v = String(str.dropFirst())
            if !seen.contains(v) {
                cnt += weights[v]!
                inner[par]! += weights[v]!
                seen.remove(v)
            }
        }
    }


    let res_str = seen.popFirst()!
    print(input, res_str)

    var res = 0
    var cmap: [Int: Int] = Dictionary()
    for nei in input[res_str]! {
        print(weights[nei])
        res += weights[nei]!
        cmap[weights[nei]!]!+=1
    }

    let mostFrequent = cmap.max { $0.value < $1.value }?.key
    let adjustment = res - (mostFrequent! * cmap.count)
    return adjustment