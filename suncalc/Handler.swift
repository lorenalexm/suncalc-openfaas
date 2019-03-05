import Foundation
import Sunlight

class Handler {
	func process(with args: String) -> String {
		guard let json = args.data(using: .utf8) else {
			return responseStringWith(error: Error(code: 500, message: "Unable to extract data from string."), sun: nil)
		}

		if let coord = try? JSONDecoder().decode(Coordinate.self, from: json) {
			if !validate(coord) {
				return responseStringWith(error: Error(code: 400, message: "Invalid coordinates received."), sun: nil)
			}
			return responseStringWith(error: nil, sun: calculateSunAt(coord))
		} else {
			return responseStringWith(error: Error(code: 500, message: "Unable to decode coordinate string."), sun: nil)
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
		let serverTime = Date().iso8601
		return Sun(atCoordinate: coord, rise: rise, set: set, goldenHourBegin: goldenHourBegin, goldenHourEnd: goldenHourEnd, serverTime: serverTime)
	}

	func responseStringWith(error: Error?, sun: Sun?) -> String {
		let response = Response(error: error, sun: sun)
		if let data = try? JSONEncoder().encode(response) {
			return String(data: data, encoding: .utf8)!
		} else {
			return "Unable to create response string"
		}
	}
}
