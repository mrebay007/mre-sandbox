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
    @State private var scale = 1.0
    @Namespace private var animation
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .clipShape(RoundedRectangle(cornerRadius: 4.0))
                .matchedGeometryEffect(id: "ImageScaling", in: animation)
            VStack(alignment: .leading) {
                Text(itemName)
                    .font(Font.system(size: 20.0, weight: .semibold, design: .default))
                Text(price)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.bottom, 4)
                Button("ADD TO CART") {
                    print("Button pressed!")
                    // showingCredits.toggle()
                }
                .padding(.horizontal, 13)
                .padding(.vertical, 8)
                .fontWeight(.bold)
                .font(Font.system(size: 9.0, weight: .bold, design: .rounded))
                .background(Color.mint)
                .clipShape(Capsule())
                .foregroundColor(.black)
            }
            .padding(.leading, 4)

        }
        .frame(maxHeight: 196)
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(image: "Product-1",
                    itemName: "Lorem Ipsum Product",
                    price: "$29.99")
    }
}
