//
//  EventView.swift
//  EventsApp
//
//  Created by Hai Le on 9/10/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import UIKit
import BonMot
import EasyPeasy

struct EventViewModel {
    static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yy"
        return formatter
    }()
    
    struct EventViewStyle {
        let nameStyle: StringStyle
        let dayStyle: StringStyle
        let monthStyle: StringStyle
        
        let seatsStyle: StringStyle
        let priceStyle: StringStyle
        let venueStyle: StringStyle
        
        let labelsStyle: StringStyle
        init(nameStyle: StringStyle = Style.EventViewStyle.nameStyle,
             dayStyle: StringStyle = Style.EventViewStyle.dayStyle,
             monthStyle: StringStyle = Style.EventViewStyle.monthStyle,
             seatsStyle: StringStyle = Style.EventViewStyle.seatsStyle,
             priceStyle: StringStyle = Style.EventViewStyle.priceStyle,
             venueStyle: StringStyle = Style.EventViewStyle.venueStyle,
             labelsStyle: StringStyle = Style.EventViewStyle.tagsStyle) {
            self.nameStyle = nameStyle
            self.dayStyle = dayStyle
            self.monthStyle = monthStyle
            self.seatsStyle = seatsStyle
            self.priceStyle = priceStyle
            self.venueStyle = venueStyle
            self.labelsStyle = labelsStyle
        }
    }
    
    let model: Event
    let name: NSAttributedString
    let day: NSAttributedString
    let monthYear: NSAttributedString
    
    let seats: NSAttributedString
    let price: NSAttributedString
    let venue: NSAttributedString
    
    let labels: NSAttributedString
    init(model: Event, style: EventViewStyle = EventViewStyle()) {
        self.model = model
        name = model.name.styled(with: style.nameStyle)
        day = model.date.day().styled(with: style.dayStyle)
        monthYear = (EventViewModel.monthFormatter.string(from: model.date)).styled(with: style.monthStyle)
        seats = "Avail seats: \(model.availableSeats)".styled(with: style.seatsStyle)
        price = "$\(model.price)".styled(with: style.priceStyle)
        venue = model.venue.styled(with: style.venueStyle)
        labels = ("Tags: " + model.labels.joined(separator: ", ")).styled(with: style.labelsStyle)
    }
}

class EventView: BaseView {
    
    let leftView = UIView()
    let nameLabel = UILabel()
    let venueLabel = UILabel()
    let priceLabel = UILabel()
    let tagLabels = UILabel()
    
    let rightView = UIView()
    let dayLabel = UILabel()
    let monthYearLabel = UILabel()
    let seatsLabel = UILabel()
    
    override func configureSubviews() {
        super.configureSubviews()
        self.addSubview(leftView)
        leftView.addSubview(nameLabel)
        leftView.addSubview(venueLabel)
        leftView.addSubview(priceLabel)
        leftView.addSubview(tagLabels)
        
        self.addSubview(rightView)
        rightView.addSubview(dayLabel)
        rightView.addSubview(monthYearLabel)
        rightView.addSubview(seatsLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()
        leftView.easy.layout(
            Left(), Top(), Bottom()
        )
        nameLabel.easy.layout(
            Top(10), Left(10), Right(10)
        )
        venueLabel.easy.layout(
            Top(10).to(nameLabel, .bottom),
            Left().to(nameLabel, .left),
            Right().to(nameLabel, .right)
        )
        priceLabel.easy.layout(
            Top(10).to(venueLabel, .bottom),
            Left().to(nameLabel, .left),
            Right().to(nameLabel, .right)
        )
        tagLabels.easy.layout(
            Top(>=20).to(priceLabel, .bottom),
            Left().to(nameLabel, .left),
            Right().to(nameLabel, .right),
            Bottom(10)
        )
        
        rightView.easy.layout(
            Left().to(leftView, .right),
            Top(), Bottom(), Right(),
            Width(130)
        )
        dayLabel.easy.layout(
            Left(10), Right(10), Top(10),
            Size(>=50)
        )
        monthYearLabel.easy.layout(
            Top(10).to(dayLabel, .bottom),
            Left().to(dayLabel, .left),
            Right().to(dayLabel, .right)
        )
        seatsLabel.easy.layout(
            Top(>=20).to(monthYearLabel, .bottom),
            Left().to(dayLabel, .left),
            Right().to(dayLabel, .right),
            Bottom(10)
        )
        
    }
    
    override func configureStyle() {
        super.configureStyle()
        [nameLabel, venueLabel, priceLabel, tagLabels, dayLabel, monthYearLabel, seatsLabel].forEach { $0.numberOfLines = 0 }
    }
    
    func configure(with model: EventViewModel) {
        nameLabel.attributedText = model.name
        venueLabel.attributedText = model.venue
        priceLabel.attributedText = model.price
        tagLabels.attributedText = model.labels
        dayLabel.attributedText = model.day
        monthYearLabel.attributedText = model.monthYear
        seatsLabel.attributedText = model.seats
    }
}

class EventTableViewCell: BaseTableViewCell {
    let eventView = EventView()
    
    override func configureSubviews() {
        super.configureSubviews()
        self.contentView.addSubview(eventView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        eventView.easy.layout(
            Edges()
        )
    }
    
    func configure(with model: EventViewModel) {
        eventView.configure(with: model)
    }
}
