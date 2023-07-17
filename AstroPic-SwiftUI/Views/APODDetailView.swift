//
//  APODDetailView.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import SwiftUI

struct APODDetailView: View {
    
    init(photoInfo: PhotoInfo) {
        print("init detail for \(photoInfo.date)")
        self.photoInfo = photoInfo
    }
    
    let photoInfo: PhotoInfo
    
    var body: some View {
        VStack {
            //            if manager.image != nil {
            //                Image(uiImage: self.manager.image!)
            //                    .resizable()
            //                    .scaledToFit()
            //            } else {
            //                ProgressView()
            //            }
            //
            ScrollView {
                VStack(alignment: .leading) {
                    Text(photoInfo.date ?? "")
                        .font(.title)
                    Text(photoInfo.title ?? "")
                        .font(.headline)
                    Text(photoInfo.explanation ?? "")
                }
            }
            .padding()
        }
    }
}

struct APODDetailView_Previews: PreviewProvider {
    static var previews: some View {
        APODDetailView(photoInfo: PhotoInfo.createDefault())
    }
}
