import Foundation
import Sunlight

struct Coordinate: Codable {
	let longitude: Double
	let latitude: Double
}

struct Sun: Codable {
	let atCoordinate: Coordinate
	let rise: Date?
	let set: Date?
	let goldenHourBegin: Date?
	let goldenHourEnd: Date?
}

class Handler {
	func process(with args: String) -> String {
		guard let json = args.data(using: .utf8) else {
			return "Unable to extract data from string"
		}

		if let coord = try? JSONDecoder().decode(Coordinate.self, from: json) {
			if !validate(coord) {
				return "Invalid coordinates received"
			}
			return "Successfully decoded coordinate"
		} else {
			return "Unable to decode string"
		}
	}

	func validate(_ coord: Coordinate) -> Bool {
		return (coord.latitude <= 90 && coord.latitude >= -90) && (coord.longitude <= 180 && coord.longitude >= -180)
	}
}
