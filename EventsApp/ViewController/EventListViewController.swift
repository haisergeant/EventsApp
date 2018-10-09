//
//  EventListViewController.swift
//  EventsApp
//
//  Created by Hai Le Thanh on 10/8/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import UIKit
import EasyPeasy
import RxCocoa
import NSObject_Rx

class EventListViewController: BaseViewController {
    
    private let repository = ServerRepository.shared
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var eventList = [EventViewModel]()
    
    override func configureSubviews() {
        super.configureSubviews()
        self.view.addSubview(tableView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        tableView.easy.layout(
            Edges()
        )
    }
    
    override func configureContent() {
        super.configureContent()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: String(describing: EventTableViewCell.self))
        tableView.allowsSelection = false
        repository.loadEvents(from: AppConstants.EVENTS_URL)
            .map { items -> [Event] in
                let list = items.filter { $0.availableSeats != 0 }
                return list.sorted(by: { (event1, event2) -> Bool in
                    return event1.date < event2.date
                })
            }
            .map { (items) -> [EventViewModel] in
                var list = [EventViewModel]()
                items.forEach { list.append(EventViewModel(model: $0)) }
                return list
            }
            .subscribe(onNext: { [weak self] list in
                self?.eventList.append(contentsOf: list)
                self?.tableView.reloadData()
            }).disposed(by: rx.disposeBag)
    }
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCell.self), for: indexPath)
        if let cell = cell as? EventTableViewCell {
            cell.configure(with: eventList[indexPath.item])
        }
        return cell
    }
}

extension EventListViewController: UITableViewDelegate {
    
}
