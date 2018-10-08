//
//  ServerRepository.swift
//  EventsApp
//
//  Created by Hai Le Thanh on 10/8/18.
//  Copyright © 2018 Hai Le. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class ServerRepository: Repository {
    static let shared = ServerRepository()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    func loadEvents(from url: String) -> Observable<[Event]> {
        return Observable.create { (observer) -> Disposable in
            let request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { [weak self] (response) in
                    if let strongSelf = self, let data = response.data {
                        do {
                            let dictionary = try strongSelf.decoder.decode([String: [Event]].self, from: data)
                            if let events = dictionary["events"] {
                                observer.onNext(events)
                                observer.onCompleted()
                            }
                        } catch {
                            observer.onError(error)
                        }
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
