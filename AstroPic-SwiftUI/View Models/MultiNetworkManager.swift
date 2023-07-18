//
//  MultiNetworkManager.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import Combine
import Foundation
import SwiftUI


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
        
        getMoreData(for: 10)
    
    }
    
    func getMoreData(for times: Int) {
        for i in 0..<times{
            self.daysFromToday += 1
        }
    }
    
    func fetchImage(for photoInfo: PhotoInfo) {
        // fetch image from photoInfo.url
        // set image to photoInfo.image
        
        guard photoInfo.image == nil, let url = photoInfo.url else {
            return
        }
        
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Fetch image error: \(error.localizedDescription)")
            } else if let data = data, let image = UIImage(data: data), let index = self.infos.firstIndex(where: { $0.id == photoInfo.id}) {
                DispatchQueue.main.async {
                    self.infos[index].image = image
                }
            }
        }
        task.resume()
    }
}
