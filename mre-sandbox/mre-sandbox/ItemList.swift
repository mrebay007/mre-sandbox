//
//  ContentView.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

struct ItemList: View {
    @StateObject var listItems = ShoppingList()
    @State private var showingCredits = false
    
    var body: some View {
        HStack(alignment: .center) {
            Button("Shopping Cart") {
                showingCredits.toggle()
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 14)
            .fontWeight(.bold)
            .font(Font.system(size: 14.0, weight: .bold, design: .rounded))
            .background(Color.white)
            .clipShape(Capsule())
            .foregroundColor(.black)
            
            .sheet(isPresented: $showingCredits) {
                ProductView2()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.automatic)
            }
        }

        Section {
            List {
                ForEach(listItems.itemContent) { row in
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
            .navigationTitle("Robots for Sale")
            .refreshable {
                print("Refreshing...")
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Color.clear.frame(height: 16)
        

        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemList(itemContent: ItemData.itemContent)
//    }
//}
