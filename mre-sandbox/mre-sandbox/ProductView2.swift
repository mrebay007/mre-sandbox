//
//  ProductView2.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

struct ProductView2: View {
    @StateObject var listItems = ShoppingList()
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Text("Shopping Cart")
                .fontWeight(.bold)
            List {
                ForEach(listItems.itemContent, id: \.self) { row in
                    HStack {
                        Image(row.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: 2.0))
                            .padding(.trailing, 6)

                        VStack(alignment: .leading) {
                            Text(row.itemName.uppercased())
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.mint)
                            Text(row.price)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(minHeight: 64)

                }
            }
            .navigationTitle("Cart View")
            
        }

    }
}

struct ScoreView: View {
    
    @EnvironmentObject var shopList: ShoppingList

    var body: some View {
        Text("Score: ")
    }
}
