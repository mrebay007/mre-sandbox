//
//  ProductView2.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

struct ProductView2: View {
    @StateObject var listItems = ShoppingList()
    // var itemContent: [Item]
    
    var body: some View {
        VStack {
            Text("Cart View")
                .font(.largeTitle)
            List {
                ForEach(listItems.itemContent, id: \.self) { row in
                    HStack {
                        Text(row.image)
                        Text(row.itemName.uppercased())
                        Text(row.price)
                            .font(.largeTitle)
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.mint)
                            // .background(Color.mint)
                            .clipped()
                    }

                }
            }
            
        }

    }
}

struct ScoreView: View {
    
    @EnvironmentObject var shopList: ShoppingList

    var body: some View {
        Text("Score: ")
    }
}

//struct ProductView2_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductView2(itemContent: ItemData.itemContent)
//    }
//}
