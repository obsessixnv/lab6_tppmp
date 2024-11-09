import Foundation

// Структура для опису точки
struct Point {
    private(set) var x: Double
    private(set) var y: Double
    private(set) var radius: Double
    private(set) var angle: Double
    
    // Ініціалізатор для декартових координат
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
        self.radius = sqrt(x * x + y * y)
        self.angle = atan2(y, x)
    }
    
    // Ініціалізатор для полярних координат
    init(radius: Double, angle: Double) {
        self.radius = radius
        self.angle = angle
        self.x = radius * cos(angle)
        self.y = radius * sin(angle)
    }
}

// Перерахування для типу фігури
enum ShapeType {
    case unknown
    case point
    case line
    case triangle
    case quadrilateral
    case polygon
}

// Структура для опису фігури
struct Shape {
    private var points: [Point]  // Закритий масив точок
    
    // Властивість для визначення типу фігури
    var type: ShapeType {
        switch points.count {
        case 0: return .unknown
        case 1: return .point
        case 2: return .line
        case 3: return .triangle
        case 4: return .quadrilateral
        default: return .polygon
        }
    }
    
    // Ініціалізатор з масиву точок
    init(points: [Point]) {
        self.points = points
    }
    
    // Ініціалізатор з ряду точок
    init(points: Point...) {
        self.points = points
    }
    
    // Індексатор для доступу до точок за індексом
    subscript(index: Int) -> Point? {
        guard index >= 0 && index < points.count else { return nil }
        return points[index]
    }
    
    // Властивість для обчислення периметру фігури
    var perimeter: Double {
        guard points.count > 1 else { return 0 }
        
        var perimeter = 0.0
        for i in 0..<points.count {
            let nextIndex = (i + 1) % points.count
            perimeter += Shape.distanceBetween(points[i], points[nextIndex])
        }
        return perimeter
    }
    
    // Властивість для обчислення площі фігури (методом Гаусса)
    var area: Double {
        guard points.count > 2 else { return 0 }
        
        var sum = 0.0
        for i in 0..<points.count {
            let nextIndex = (i + 1) % points.count
            sum += points[i].x * points[nextIndex].y - points[i].y * points[nextIndex].x
        }
        return abs(sum) / 2.0
    }
    
    // Функція для обчислення відстані між двома точками
    static func distanceBetween(_ point1: Point, _ point2: Point) -> Double {
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
}

// Приклад використання
let pointA = Point(x: 0, y: 0)
let pointB = Point(x: 3, y: 0)
let pointC = Point(x: 3, y: 4)
let pointD = Point(x: 0, y: 4)

let triangle = Shape(points: pointA, pointB)
let quadrilateral = Shape(points: pointA, pointB, pointC, pointD)

print("Triangle type: \(triangle.type)")
print("Quadrilateral type: \(quadrilateral.type)")

print("Triangle perimeter: \(triangle.perimeter)")
print("Triangle area: \(triangle.area)")

print("Quadrilateral perimeter: \(quadrilateral.perimeter)")
print("Quadrilateral area: \(quadrilateral.area)")
