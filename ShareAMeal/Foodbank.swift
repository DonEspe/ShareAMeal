//
//  Foodbank.swift
//  ShareAMeal
//
//  Created by Don Espe on 10/17/23.
//

import Foundation

enum CodingKeys: String, CodingKey {
    case name, slug, phone, email, address, distance = "distance_m"
}

struct Foodbank: Codable, Identifiable {
    var id: String { slug }
    var name: String
    var slug: String
    var phone: String
    var email: String
    var address: String
    var distance: Int

    var distanceFormatted: String {
        let measurement = Measurement(value: Double(distance), unit: UnitLength.meters)

        let measurementString = measurement.formatted(.measurement(width: .wide))
        return "\(measurementString) from you"
    }
}
