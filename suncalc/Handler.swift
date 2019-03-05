import Foundation
import Sunlight

struct Coordinate: Codable {
	let longitude: Double
	let latitude: Double
}

struct Sun: Codable {
	let atCoordinate: Coordinate?
	let onDate: Date?
	let rise: Date?
	let set: Date?
	let goldenHourBegin: Date?
	let goldenHourEnd: Date?
}

class Handler {
	func process(with args: String) -> String {
		return "Success"
	func validate(_ coord: Coordinate) -> Bool {
		return (coord.latitude < 90 && coord.latitude > -90) && (coord.longitude < 180 && coord.longitude > -180)
	}
}
