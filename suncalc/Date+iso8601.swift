// ISO8601 Date Formatter Extensions
// Source: https://stackoverflow.com/questions/28016578/how-to-create-a-date-time-stamp-and-format-as-iso-8601-rfc-3339-utc-time-zone#28016692
import Foundation

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
