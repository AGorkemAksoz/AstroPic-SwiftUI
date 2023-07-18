//
//  PicOfTodayView.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import SwiftUI


/// This view for firt version of this app

struct PicOfTodayView: View {
    
    @ObservedObject var manager = NetworkManager()
    @State private var showSwitchDate: Bool = false
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            
            HStack(alignment: .bottom) {
                Spacer()
                Button {
                    showSwitchDate = true
                } label: {
                        Image(systemName: "calendar")
                        Text("Switch Day")
                }
                .padding(.trailing)
                .popover(isPresented: $showSwitchDate) {
                    SelectDateView( manager: manager)

                }
            }
            

            
            if manager.image != nil {
                Image(uiImage: self.manager.image!)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
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
