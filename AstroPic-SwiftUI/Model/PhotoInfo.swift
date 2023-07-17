//
//  PhotoInfo.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import Foundation

// MARK: - PhotoInfo
struct PhotoInfo: Codable {
    var date, explanation: String?
    var hdurl: String?
    var mediaType, serviceVersion, title: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
    
    init() {
        self.explanation = ""
        self.title = ""
        self.date = ""
    }
    
    static func createDefault() -> PhotoInfo{
        var photoInfo = PhotoInfo()
        photoInfo.title = "Shells and Arcs around Star CW Leonis"
        photoInfo.explanation = "What's happening around this star? No one is sure. CW Leonis is the closest carbon star, a star that appears orange because of atmospheric carbon dispersed from interior nuclear fusion. But CW Leonis also appears engulfed in a gaseous carbon-rich nebula. What causes the nebula's complexity is unknown, but its geometry of shells and arcs are surely intriguing. The featured image by the Hubble Space Telescope details this complexity. The low surface gravity of carbon stars enhances their ability to expel carbon and carbon compounds into space. Some of this carbon ends up forming dark dust that is commonly seen in the nebulas of young star-forming regions and the disks of galaxies.  Humans and all Earth-based life are carbon-based, and at least some of our carbon was likely once circulating in the atmospheres of near-death stars like carbon stars."
        photoInfo.date = "2023-07-17"
        return photoInfo
    }
}
