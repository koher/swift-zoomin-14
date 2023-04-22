import Foundation

struct Vector4D<Element: Numeric>: Equatable {
    var x: Element
    var y: Element
    var z: Element
    var w: Element
}

extension Vector4D {
    // 加算
    static func + (lhs: Vector4D, rhs: Vector4D) -> Vector4D {
        return Vector4D(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z, w: lhs.w + rhs.w)
    }

    // 減算
    static func - (lhs: Vector4D, rhs: Vector4D) -> Vector4D {
        return Vector4D(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z, w: lhs.w - rhs.w)
    }

    // 乗算
    static func * (lhs: Vector4D, rhs: Vector4D) -> Vector4D {
        return Vector4D(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z, w: lhs.w * rhs.w)
    }
}

extension Vector4D where Element: FloatingPoint {
    static func /(lhs: Vector4D<Element>, rhs: Vector4D<Element>) -> Vector4D<Element> {
        return Vector4D<Element>(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z, w: lhs.w / rhs.w)
    }
}

extension Vector4D where Element == Int {
    static func /(lhs: Vector4D<Element>, rhs: Vector4D<Element>) -> Vector4D<Element> {
        return Vector4D<Element>(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z, w: lhs.w / rhs.w)
    }
    
    static func /(lhs: Vector4D<Element>, rhs: Element) -> Vector4D<Element> {
        return Vector4D<Element>(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs, w: lhs.w / rhs)
    }
}
