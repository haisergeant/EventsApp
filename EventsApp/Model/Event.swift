//
//  Event.swift
//  EventsApp
//
//  Created by Hai Le Thanh on 10/8/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import Foundation

struct Event: Decodable {
    let name: String
    let date: Date
    let availableSeats: Int
    let price: Double
    let venue: String
    let labels: [String]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case date
        case availableSeats = "available_seats"
        case price
        case venue
        case labels
    }
}
