func quadraticEquation(a: Double, b: Double, c: Double) -> [Double] {
  let x1 = (-b + ((b*b) - 4*a*c).squareRoot())/(2*a)
  let x2 = (-b - ((b*b) - 4*a*c).squareRoot())/(2*a)
  return [x1, x2]
}

var solution = quadraticEquation(a: 3, b: -11, c: -4)
print("Root 1 is \(solution[0])")
print("Root 2 is \(solution[1])")




