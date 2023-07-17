//
//  NetworkManager.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import Combine
import Foundation
import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var photoInfo = PhotoInfo()
    @Published var image: UIImage? = nil
    @Published var date: Date = Date()
    
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        guard let url = URL(string: Const.baseURL) else { return }
        
        guard let fullURL = url.withQuery(["api_key" : Const.key]) else { return }
        
        $date.removeDuplicates()
            .sink { value in
                self.image = nil
            }.store(in: &subscriptions)
        
        $date.removeDuplicates()
            .map { self.createURL(for: $0)
            }.flatMap { url in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .decode(type: PhotoInfo.self, decoder: JSONDecoder())
                    .catch { error in
                        Just(PhotoInfo())
                    }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.photoInfo, on: self)
            .store(in: &subscriptions)
        
        
        URLSession.shared.dataTaskPublisher(for: fullURL)
            .map(\.data)
            .decode(type: PhotoInfo.self, decoder: JSONDecoder())
            .catch { error in
                Just(PhotoInfo())
            }
            .receive(on: RunLoop.main)
            .assign(to: \.photoInfo, on: self)
            .store(in: &subscriptions)
        
        
        $photoInfo
            .filter { $0.url != nil }
            .map { photoInfo -> String in
                return photoInfo.url!
            }
            .flatMap { url in
                URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
                    .map(\.data)
                    .catch { error in
                        return Just(Data())
                    }
            }
            .map { out -> UIImage? in
                UIImage(data: out)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
        
        
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("fetch complete finished")
//                case .failure(let failure):
//                    print("fetch complete wit failure: \(failure.localizedDescription)")
//                }
//            } receiveValue: { data, response in
//                if let description = String(data: data, encoding: .utf8) {
//                    print(description)
//                }
//            }.store(in: &subscriptions)

    }
    
    func createURL(for date: Date) -> URL {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        let url = URL(string: Const.baseURL)!
        
        let fullURL = url.withQuery(["api_key" : Const.key, "date": dateString])!
        
        return fullURL
    }
}
