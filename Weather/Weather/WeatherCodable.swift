import Foundation
import UIKit

struct weatherCodable: Decodable {
    var list: [List]
    var city: City
}
struct List: Decodable {
    var dt: TimeInterval
    var main: Main
    var clouds: Clouds
    var wind: Wind
}
struct Main: Decodable {
    var temp: Double
    var humidity: Int
}
struct Clouds: Decodable {
    var all: Int
}
struct Wind: Decodable {
    var speed: Double
}
struct City: Decodable {
    var name: String
}
