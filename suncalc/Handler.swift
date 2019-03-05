import Foundation
struct SunData: Codable {
	var latitude: Double?
	var longitude: Double?
	var date: Date?
	var sunrise: Date?
	var sunset: Date?
	var goldenHourBegin: Date?
	var goldenHourEnd: Date?
}

class Handler {
	func process(with args: String) -> String {
		return "Success"
	func validate(latitude: Double, longitude: Double) -> Bool {
		return (latitude < 90 && latitude > -90) && (longitude < 180 && longitude > -180)
	}
}
