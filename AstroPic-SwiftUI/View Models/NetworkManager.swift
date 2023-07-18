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
            .map { NetworkHelper.createURL(for: $0)
            }.flatMap { url in
                NetworkHelper.createPublisher(url: url)
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

    }
    

}
