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
            Image(systemName: "seal.fill")
                .font(.title2)
                .foregroundColor(.orange)
                .frame(minWidth: 32, minHeight: 16)
                .padding(.trailing, 2)
            VStack(alignment: .leading, spacing: 0) {
                Text(itemName)
                    .font(Font.system(size: 20.0, weight: .semibold, design: .default))
                    .padding(.bottom, 4)
                Text(price)
                    .font(.body)
                    .foregroundColor(.gray)
                Text(image)
                    .font(.footnote)
                    .foregroundColor(.gray)
                
            }
        }
        .frame(minHeight: 60)
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(image: "Product-1",
                    itemName: "Lorem Ipsum Product",
                    price: "$29.99")
    }
}
