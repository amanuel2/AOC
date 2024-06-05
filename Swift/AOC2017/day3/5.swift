import Foundation


func solve(_ input: Int) -> Int
{
    var sideLength = 1
    while sideLength * sideLength < input {
        sideLength += 2
    }

    let square = sideLength * sideLength

    let distanceToCenterOfSide = (sideLength - 1) / 2
    let distanceAlongSide = (square - input) % (sideLength - 1)

    return distanceToCenterOfSide + abs(distanceToCenterOfSide - distanceAlongSide)
}


print(solve(312051))