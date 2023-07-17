//
//  MultiNetworkManager.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import Combine
import Foundation


class MultiNetworkManager: ObservableObject {
    
    @Published var infos = [PhotoInfo]()
    
    @Published var daysFromToday: Int = 0
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
//        let times = 0..<10
//
//        times.publisher
        $daysFromToday
            .map { daysFromToday in
                return NetworkHelper.createDate(daysFromToday: daysFromToday)
            }.map { date in
                return NetworkHelper.createURL(for: date)
            }.flatMap { url in
                return NetworkHelper.createPublisher(url: url)
            }.scan([]) { partialValue, newValue in
                return partialValue + [newValue]
            }
            .tryMap({ infos in
                infos.sorted { $0.formattedDate > $1.formattedDate }
            })
            .catch{ error in
                Just([PhotoInfo]())
            }
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.infos, on: self)
            .store(in: &subscriptions)
        
        getMoreData()
    
    }
    
    func getMoreData() {
        for i in 1..<10 {
            self.daysFromToday = i
        }
    }
}
