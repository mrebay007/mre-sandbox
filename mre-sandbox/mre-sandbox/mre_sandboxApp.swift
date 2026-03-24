//
//  mre_sandboxApp.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

@main
struct mre_sandboxApp: App {
    @State var selection: Item? = nil
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationSplitView {
                    ItemList()
                } detail: {
                    Text("Robots For Sale")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                }
                .tabItem {
                    Label("Shop", systemImage: "cart")
                }
                
                AudioPage()
                    .tabItem {
                        Label("Audio", systemImage: "music.note.list")
                    }
            }
        }
    }
}
