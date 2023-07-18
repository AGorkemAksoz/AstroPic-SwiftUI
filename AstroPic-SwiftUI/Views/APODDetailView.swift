//
//  APODDetailView.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import SwiftUI

struct APODDetailView: View {
    
    init(photoInfo: PhotoInfo, manager: MultiNetworkManager) {
        print("init detail for \(photoInfo.date)")
        self.photoInfo = photoInfo
        self.manager = manager
    }
    
    let photoInfo: PhotoInfo
    
    @ObservedObject var manager: MultiNetworkManager
    
    var body: some View {
        VStack {
            if photoInfo.image != nil {
                    Image(uiImage: self.photoInfo.image!)
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
    
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
        .navigationTitle(photoInfo.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.manager.fetchImage(for: self.photoInfo)
        }
    }
}

struct APODDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            APODDetailView(photoInfo: PhotoInfo.createDefault(), manager: MultiNetworkManager())
        }
    }
}
