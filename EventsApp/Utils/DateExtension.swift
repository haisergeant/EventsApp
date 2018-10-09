//
//  DateExtension.swift
//  EventsApp
//
//  Created by Hai Le Thanh on 10/9/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import UIKit

extension Date {
    func day() -> String {
        let calendar = Calendar.current
        let component = calendar.component(.day, from: self)
        return String(component)
    }
    
    func month() -> String {
        let calendar = Calendar.current
        let component = calendar.component(.month, from: self)
        return String(component)
    }
    
    func year() -> String {
        let calendar = Calendar.current
        let component = calendar.component(.year, from: self)
        return String(component)
    }
}
