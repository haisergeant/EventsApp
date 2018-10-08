//
//  EventListViewController.swift
//  EventsApp
//
//  Created by Hai Le Thanh on 10/8/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import UIKit
import RxCocoa
import NSObject_Rx

class EventListViewController: BaseViewController {
    
    let repository = ServerRepository.shared
    
    override func configureContent() {
        super.configureContent()
        
        repository.loadEvents(from: AppConstants.EVENTS_URL)
            .map { items -> [Event] in
                let list = items.filter { $0.availableSeats != 0 }
                return list.sorted(by: { (event1, event2) -> Bool in
                    return event1.date < event2.date
                })
            }
            .subscribe(onNext: { eventList in
                print(eventList.count)
            }).disposed(by: rx.disposeBag)
    }
}
