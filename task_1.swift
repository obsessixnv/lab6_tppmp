import Foundation

// Структура для зберігання точки в декартових та полярних координатах
struct Point {
    private(set) var x: Double
    private(set) var y: Double
    private(set) var radius: Double
    private(set) var angle: Double
    
    // Ініціалізатор для декартових координат
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
        self.radius = sqrt(x * x + y * y)  // Розрахунок радіусу
        self.angle = atan2(y, x)           // Розрахунок кута
    }
    
    // Ініціалізатор для полярних координат
    init(radius: Double, angle: Double) {
        self.radius = radius
        self.angle = angle
        self.x = radius * cos(angle)       // Розрахунок x
        self.y = radius * sin(angle)       // Розрахунок y
    }
}

// Структури для декартових та полярних координат
struct CartesianPoint {
    private(set) var x: Double
    private(set) var y: Double
    
    // Ініціалізатор для декартових координат
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

struct PolarPoint {
    private(set) var radius: Double
    private(set) var angle: Double
    
    // Ініціалізатор для полярних координат
    init(radius: Double, angle: Double) {
        self.radius = radius
        self.angle = angle
    }
}

// Розширення для функцій зміщення точки
extension Point {
    // Зміщення точки за декартовими координатами
    mutating func shiftByCartesian(dx: Double, dy: Double) {
        self.x += dx
        self.y += dy
        self.radius = sqrt(x * x + y * y)
        self.angle = atan2(y, x)
    }
    
    // Зміщення точки за полярними координатами
    mutating func shiftByPolar(dradius: Double, dangle: Double) {
        self.radius += dradius
        self.angle += dangle
        self.x = radius * cos(angle)
        self.y = radius * sin(angle)
    }
}

// Розширення для функції, яка повертає рядкове представлення точки
extension Point {
    func description(inCoordinateSystem system: String = "cartesian") -> String {
        if system == "polar" {
            return "Point in Polar Coordinates: (radius: \(radius), angle: \(angle))"
        } else {
            return "Point in Cartesian Coordinates: (x: \(x), y: \(y))"
        }
    }
}

// Розширення для обчислення відстані між двома точками
extension Point {
    static func distanceBetween(_ point1: Point, _ point2: Point) -> Double {
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
}

// Опис користувацьких типів для координат
struct CartesianCoordinates {
    var x: Double
    var y: Double
}

struct PolarCoordinates {
    var radius: Double
    var angle: Double
}

// Розширення для ініціалізації точки з користувацьких типів
extension Point {
    // Ініціалізатор на основі користувацького типу CartesianCoordinates
    init(fromCartesianCoordinates coords: CartesianCoordinates) {
        self.x = coords.x
        self.y = coords.y
        self.radius = sqrt(x * x + y * y)
        self.angle = atan2(y, x)
    }
    
    // Ініціалізатор на основі користувацького типу PolarCoordinates
    init(fromPolarCoordinates coords: PolarCoordinates) {
        self.radius = coords.radius
        self.angle = coords.angle
        self.x = radius * cos(angle)
        self.y = radius * sin(angle)
    }
}

// Розширення для створення точки на основі різних типів координат
extension Point {
    // Створення точки з декартових координат
    static func createFromCartesian(x: Double, y: Double) -> Point {
        return Point(x: x, y: y)
    }
    
    // Створення точки з полярних координат
    static func createFromPolar(radius: Double, angle: Double) -> Point {
        return Point(radius: radius, angle: angle)
    }
    
    // Створення точки з користувацького типу CartesianCoordinates
    static func createFromCartesianCoordinates(coords: CartesianCoordinates) -> Point {
        return Point(fromCartesianCoordinates: coords)
    }
    
    // Створення точки з користувацького типу PolarCoordinates
    static func createFromPolarCoordinates(coords: PolarCoordinates) -> Point {
        return Point(fromPolarCoordinates: coords)
    }
}

// Приклад використання
let point1 = Point(x: 3, y: 4)
let point2 = Point(radius: 5, angle: Double.pi / 4)

print(point1.description(inCoordinateSystem: "cartesian"))
print(point2.description(inCoordinateSystem: "polar"))
print("Cartesian for point2: (x: \(point2.x), y: \(point2.y))")

let distance = Point.distanceBetween(point1, point2)
print("Distance between point1 and point2: \(distance)")

let shiftedPoint = Point(x: 1, y: 2)
var pointToShift = shiftedPoint
pointToShift.shiftByCartesian(dx: 3, dy: 4)
print(pointToShift.description())
