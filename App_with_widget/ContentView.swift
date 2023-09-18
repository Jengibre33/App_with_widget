//
//  ContentView.swift
//  App_with_widget
//
//  Created by Javier on 18/09/23.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello WidgetKit!")
                .padding()
            Button(action: {
                WidgetCenter.shared.reloadAllTimelines()
            }) {
                Text("Update Widget")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
