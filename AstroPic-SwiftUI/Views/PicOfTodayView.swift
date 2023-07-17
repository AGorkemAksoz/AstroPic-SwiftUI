//
//  PicOfTodayView.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import SwiftUI

struct PicOfTodayView: View {
    
    @ObservedObject var manager = NetworkManager()
    
    var body: some View {
        VStack{
            
            if manager.image != nil {
                Image(uiImage: self.manager.image!)
                    .resizable()
                    .scaledToFit()
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text(manager.photoInfo.date ?? "")
                        .font(.title)
                    Text(manager.photoInfo.title ?? "")
                        .font(.headline)
                    Text(manager.photoInfo.explanation ?? "")
                }
            }
            .padding()
            

        }
        .padding()
    }
}

struct PicOfTodayView_Previews: PreviewProvider {
    static var previews: some View {
        let view = PicOfTodayView()
        view.manager.photoInfo = PhotoInfo.createDefault()
        view.manager.image = UIImage(named: "preview_image")
        return view
    }
}
