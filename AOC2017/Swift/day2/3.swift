import Foundation

func checkSum(input: String) -> Int
{
    var res = 0
    for line in input.split(separator: "\n") {
        print(line, line.min(), line.max())
        let arr: [Int] = line.split(separator: "\t").compactMap { Int($0) }

        let min = arr.min()!
        let max = arr.max()!

        res += max-min
    }

    return res
}

func fetchInput(url: String, completion: @escaping (String?, Error?) -> Void) {
    guard let url = URL(string: url) else {
        print("Invalid URL")
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(nil, error)
        } else if let data = data {
            let str = String(data: data, encoding: .utf8)
            completion(str, nil)
        }
    }

    task.resume()
}

fetchInput(url: "https://adventofcode.com/2017/day/2/input") { (result, error) in
    if let error = error {
        print("Error: \(error)")
    } else if let result = result {
        print(checkSum(input: result))
    }
}
// print(CommandLine.arguments)
// print(checkSum(input: CommandLine.arguments[1]))
