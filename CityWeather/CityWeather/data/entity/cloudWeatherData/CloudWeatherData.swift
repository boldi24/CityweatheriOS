import Foundation

struct CloudWeatherData : Codable {
//  let coord : Coord?
	let weather : [Weather]?
//  let base : String?
	let main : Main?
//  let visibility : Int?
  let wind : Wind?
	let clouds : Clouds?
//  let dt : Int?
//  let sys : Sys?
//  let id : Int?
//  let name : String?
//  let cod : Int?

	enum CodingKeys: String, CodingKey {

//    case coord
		case weather = "weather"
//    case base = "base"
		case main
//    case visibility = "visibility"
		case wind
		case clouds
//    case dt = "dt"
//    case sys
//    case id = "id"
//    case name = "name"
//    case cod = "cod"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
//    coord = try Coord(from: decoder)
		weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
//    base = try values.decodeIfPresent(String.self, forKey: .base)
		main = try values.decodeIfPresent(Main.self, forKey: .main)
//    visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
		wind = try Wind(from: decoder)
		clouds = try Clouds(from: decoder)
//    dt = try values.decodeIfPresent(Int.self, forKey: .dt)
//    sys = try Sys(from: decoder)
//    id = try values.decodeIfPresent(Int.self, forKey: .id)
//    name = try values.decodeIfPresent(String.self, forKey: .name)
//    cod = try values.decodeIfPresent(Int.self, forKey: .cod)
	}

}
