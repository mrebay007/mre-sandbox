//
//  ItemRow.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

struct ItemRowView: View {
    var image: String
    var itemName: String
    var price: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .padding(.trailing, 2)
            VStack(alignment: .leading, spacing: 0) {
                Text(itemName)
                    .font(Font.system(size: 20.0, weight: .semibold, design: .default))
                    .padding(.bottom, 4)
                Text(price)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                Button("ADD TO CART") {
                    print("Button pressed!")
                    // showingCredits.toggle()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .fontWeight(.bold)
                .font(.footnote)
                .background(Color.mint)
                .clipShape(Capsule())
                .foregroundColor(.black)
            }

        }
        .frame(maxHeight: 128)
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(image: "Product-1",
                    itemName: "Lorem Ipsum Product",
                    price: "$29.99")
    }
}
