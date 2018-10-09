//
//  Constants.swift
//  EventsApp
//
//  Created by Hai Le Thanh on 10/9/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import UIKit
import BonMot

struct AppConstants {
    static let EVENTS_URL = "https://s3-ap-southeast-2.amazonaws.com/bridj-coding-challenge/events.json"
}

struct Style {
    static let regularFont = UIFont.systemFont(ofSize: 14.0)
    static let boldFont = UIFont.boldSystemFont(ofSize: 16.0)
    
    static let darkBrown = UIColor(red: 94.0/255.0, green: 74.0/255.0, blue: 78.0/255.0, alpha: 1.0)
    static let lightBrown = UIColor(red: 198.0/255.0, green: 163.0/255.0, blue: 169.0/255.0, alpha: 1.0)
    
    static let darkPurple = UIColor(red: 107.0/255.0, green: 91.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    static let lightPurple = UIColor(red: 158.0/255.0, green: 145.0/255.0, blue: 227.0/255.0, alpha: 1.0)
    
    struct EventViewStyle {
        static let nameStyle = StringStyle(.font(boldFont), .color(darkBrown))
        static let venueStyle = StringStyle(.font(regularFont), .color(lightBrown))
        static let priceStyle = StringStyle(.font(regularFont), .color(lightBrown))
        static let tagsStyle = StringStyle(.font(regularFont), .color(lightBrown))
        
        static let dayStyle = StringStyle(.font(UIFont.boldSystemFont(ofSize: 40)),
                                          .color(darkPurple),
                                          .alignment(.center))
        static let monthStyle = StringStyle(.font(UIFont.systemFont(ofSize: 20)),
                                            .color(lightPurple),
                                            .alignment(.center))
        static let seatsStyle = StringStyle(.font(regularFont), .color(lightPurple))
    }
}
