//
//  SelectDateView.swift
//  AstroPic-SwiftUI
//
//  Created by Gorkem on 17.07.2023.
//

import SwiftUI

struct SelectDateView: View {
    @State private var date = Date()
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var manager: NetworkManager
    
    var body: some View {
        VStack {
            Text("Select a day")
                .font(.headline)
            
            DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {  }.labelsHidden()
            
            Button {
                self.manager.date = date
                dismiss()
            } label: {
                Text("Done")
            }

        }
    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView( manager: NetworkManager())
    }
}
