
import Foundation

// Root
struct NasaFeedResponse: Decodable {
    let links: FeedLinks
    let element_count: Int
    let near_earth_objects: [String: [NeoElement]]
}

struct FeedLinks: Decodable {
    let next: String?
    let previous: String?
    let `self`: String?
}

// NEO object
struct NeoElement: Decodable {
    let id: String
    let neo_reference_id: String
    let name: String
    let nasa_jpl_url: String
    let absolute_magnitude_h: Double
    let estimated_diameter: EstimatedDiameter
    let is_potentially_hazardous_asteroid: Bool
    let close_approach_data: [CloseApproachData]
    let is_sentry_object: Bool    
}

struct EstimatedDiameter: Decodable {
    let kilometers: DiameterRange
    let meters: DiameterRange
    let miles: DiameterRange
    let feet: DiameterRange
}

struct DiameterRange: Decodable {
    let estimated_diameter_min: Double
    let estimated_diameter_max: Double
}

struct CloseApproachData: Decodable {
    let close_approach_date: String
    let close_approach_date_full: String
    let epoch_date_close_approach: Int64
    let relative_velocity: RelativeVelocity
    let miss_distance: MissDistance
    let orbiting_body: String
}

struct RelativeVelocity: Decodable {
    let kilometers_per_second: String
    let kilometers_per_hour: String
    let miles_per_hour: String
}

struct MissDistance: Decodable {
    let astronomical: String
    let lunar: String
    let kilometers: String
    let miles: String
}
