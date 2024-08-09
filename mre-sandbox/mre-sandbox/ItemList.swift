//
//  ContentView.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

struct ItemList: View {
    var itemContent: [Item]
    
    var body: some View {
        Section {
            List {
                ForEach(itemContent) { row in
                    NavigationLink(
                        destination: Destination.view(forSelection: row.destination),
                        label: {
                            ItemRowView(image: row.image,
                                        itemName: row.itemName,
                                        price: row.price)
                        })
                        .fixedSize(horizontal: false, vertical: true)
                        .listRowInsets(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Robots")
            .refreshable {
                print("Refreshing...")
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Color.clear.frame(height: 16)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemList(itemContent: ItemData.itemContent)
    }
}
