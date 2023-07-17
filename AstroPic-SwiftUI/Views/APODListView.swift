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
        List {
            ForEach(manager.infos, id: \.id) { info in
                APODRow(photoInfo: info)
            }
        }
    }
}

struct APODListView_Previews: PreviewProvider {
    static var previews: some View {
        APODListView()
    }
}
