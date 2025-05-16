//
//  Models.swift
//  AmadeusBookingApp
//
//  Created by Margels on 24/10/23.
//

import Foundation

enum LocationSubtype: String {
    case airport = "AIRPORT"
    case city = "CITY"
}

struct LocationMatchesModel: Decodable {
    var data: [LocationModel]
}

struct LocationModel: Decodable {
    var detailedName: String
    var name: String
    var iataCode: String
}

struct FlightAvailabilitySearch: Encodable {
    var originDestinations: [FlightOriginDestination]
    var travelers: [FlightTravelers]
    let sources: [String] = ["GDS"]
    init(origin: String, destination: String, date: Date, numberOfAdults: Int) {
        self.originDestinations = [
            .init(
                id: "1",
                originLocationCode: origin,
                destinationLocationCode: destination,
                departureDateTime: .init(date: date.yyyyMMdd, time: date.HHmmss)
            )
        ]
        var travelers: [FlightTravelers] = []
        for n in 1...numberOfAdults {
            travelers.append(.init(id: n.description, travelerType: .ADULT))
        }
        self.travelers = travelers
    }
}

struct FlightOriginDestination: Encodable {
    let id: String
    let originLocationCode: String
    let destinationLocationCode: String
    let departureDateTime: FlightTimeRange
}

struct FlightTravelers: Encodable {
    let id: String
    let travelerType: FlightTravelerType
    let associatedAdultId: String? = nil
}

struct FlightOffersModel: Decodable {
    let data: [FlightOfferDetails]
}

struct FlightOfferDetails: Decodable {
    var segments: [SegmentDetails]
}

struct SegmentDetails: Encodable, Decodable {
    let number: String
    let id: String
    let departure: AirportDetails
    let arrival: AirportDetails
    let carrierCode: String
    let numberOfStops: Int
}

enum FlightTravelerType: String, Encodable {
    case ADULT = "ADULT"
    
    init(from string: String) {
        switch string {
        case "ADULT": self = .ADULT
        default: self = .ADULT
        }
    }
}

struct FlightTimeRange: Encodable {
    let date: String
    let time: String
}


struct AirportDetails: Encodable, Decodable {
    let iataCode: String
    let terminal: String?
    let at: String
}
