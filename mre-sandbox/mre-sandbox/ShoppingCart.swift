//
//  ShoppingCart.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/11/24.
//
import SwiftUI



struct ShoppingCart: View {
    @StateObject var listItems = ShoppingList()
    @EnvironmentObject var item: ShoppingList
    
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
            Divider()
            HStack {
                Text("TOTAL")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    
                Text("$27,999")
                    .font(.subheadline)
                
                Button("Checkout") {
                    print("Opening...")
                    
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 14)
                .fontWeight(.bold)
                .font(Font.system(size: 14.0, weight: .bold, design: .rounded))
                .background(Color.white)
                .clipShape(Capsule())
                .foregroundColor(.black)
            }
            .frame(alignment: .leading)
        }

    }
}

struct ShoppingCart_Preview: View {
    
    @EnvironmentObject var shopList: ShoppingList

    var body: some View {
        Text("Score: ")
    }
}
