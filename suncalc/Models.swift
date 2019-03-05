import Foundation

struct Response: Codable {
	let error: Error?
	let sun: Sun?
}

struct Error: Codable {
	let code: Int
	let message: String
}

struct Coordinate: Codable {
	let longitude: Double
	let latitude: Double
}

struct Sun: Codable {
	let atCoordinate: Coordinate
	let rise: String
	let set: String
	let goldenHourBegin: String
	let goldenHourEnd: String
	let serverTime: String

	enum CodingKeys: String, CodingKey {
		case atCoordinate = "at_coordinate"
		case rise
		case set
		case goldenHourBegin = "golden_hour_begin"
		case goldenHourEnd = "golden_hour_end"
		case serverTime = "server_time"
	}
}
