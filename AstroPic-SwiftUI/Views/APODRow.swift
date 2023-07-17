//
//  APODRow.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import SwiftUI

struct APODRow: View {
    
    let photoInfo: PhotoInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(photoInfo.date ?? "").bold()
            Text(photoInfo.title ?? "")
        }
        .onAppear {
            print(photoInfo.title)
        }
    }
}

struct APODRow_Previews: PreviewProvider {
    static var previews: some View {
        APODRow(photoInfo: PhotoInfo.createDefault())
    }
}
