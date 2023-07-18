//
//  APODListView.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import SwiftUI

struct APODListView: View {
    @ObservedObject var manager = MultiNetworkManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(manager.infos, id: \.id) { info in
                    NavigationLink {
                        APODDetailView(photoInfo: info, manager: manager)
                    } label: {
                        APODRow(photoInfo: info)
                            .onAppear {
                                // Pagination
                                
                                print(info)
                                if let index = self.manager.infos.firstIndex(where: { $0.id == info.id}),
                                   index == self.manager.infos.count - 1 && self.manager.daysFromToday == self.manager.infos.count - 1 {
                                    self.manager.getMoreData(for: 10)
                                }
                            }
                    }
                }
                
                ForEach(0..<10) { _ in
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 50)
                }
            }
            .navigationTitle("Astronomy Pictures")
        }
    }
}

struct APODListView_Previews: PreviewProvider {
    static var previews: some View {
        APODListView()
    }
}
