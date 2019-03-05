import Foundation
import Sunlight

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

	enum CodingKeys: String, CodingKey {
		case atCoordinate = "at_coordinate"
		case rise
		case set
		case goldenHourBegin = "golden_hour_begin"
		case goldenHourEnd = "golden_hour_end"
	}
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
			let sun = calculateSunAt(coord)
			if let data = try? JSONEncoder().encode(sun) {
				return String(data: data, encoding: .utf8)!
			} else {
				return "Unable to encode response"
			}
		} else {
			return "Unable to decode string"
		}
	}

	func validate(_ coord: Coordinate) -> Bool {
		return (coord.latitude <= 90 && coord.latitude >= -90) && (coord.longitude <= 180 && coord.longitude >= -180)
	}

	func calculateSunAt(_ coord: Coordinate) -> Sun {
		let light = SunlightCalculator(latitude: coord.latitude, longitude: coord.longitude)
		let rise = light.calculate(.dawn, twilight: .civil)?.iso8601 ?? "-1"
		let set = light.calculate(.dusk, twilight: .civil)?.iso8601 ?? "-1"
		let goldenHourBegin = light.calculate(.dusk, twilight: .custom(-4))?.iso8601 ?? "-1"
		let goldenHourEnd = light.calculate(.dusk, twilight: .custom(6))?.iso8601 ?? "-1"
		return Sun(atCoordinate: coord, rise: rise, set: set, goldenHourBegin: goldenHourBegin, goldenHourEnd: goldenHourEnd)
	}
}

// ISO8601 Date Formatter Extensions
// Source: https://stackoverflow.com/questions/28016578/how-to-create-a-date-time-stamp-and-format-as-iso-8601-rfc-3339-utc-time-zone#28016692
extension ISO8601DateFormatter {
  convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
	  self.init()
	  self.formatOptions = formatOptions
	  self.timeZone = timeZone
  }
}

extension Formatter {
  static let iso8601 = ISO8601DateFormatter([.withInternetDateTime])
}

extension Date {
  var iso8601: String {
    return Formatter.iso8601.string(from: self)
  }
}
