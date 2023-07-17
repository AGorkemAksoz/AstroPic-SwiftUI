//
//  NetworkHelper.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import Combine
import Foundation


struct NetworkHelper {
    
    static func createFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static func createURL(for date: Date) -> URL {
        
        let formatter = createFormatter()
        let dateString = formatter.string(from: date)
        
        let url = URL(string: Const.baseURL)!
        
        let fullURL = url.withQuery(["api_key" : Const.key, "date": dateString])!
        
        return fullURL
    }
    
    static func createPublisher(url: URL) ->AnyPublisher<PhotoInfo, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PhotoInfo.self, decoder: JSONDecoder())
            .catch { error in
                Just(PhotoInfo())
            }
            .eraseToAnyPublisher()
    }
    
    static func createDate(daysFromToday: Int) -> Date {
        let today = Date()
        
        if let newDate = Calendar.current.date(byAdding: .day, value: -daysFromToday, to: today) {
            return newDate
        } else {
            return today 
        }
    }
}
