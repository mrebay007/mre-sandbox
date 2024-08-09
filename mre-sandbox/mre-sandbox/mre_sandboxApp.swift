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
            NavigationSplitView {
                ItemList(itemContent: ItemData.itemContent)
            } detail: {
                Text("Choose an example")
            }
        }
    }
}
