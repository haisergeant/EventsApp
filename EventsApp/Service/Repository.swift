//
//  Repository.swift
//  EventsApp
//
//  Created by Hai Le Thanh on 10/8/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol Repository {
    func loadEvents(from url: String) -> Observable<[Event]>
}
