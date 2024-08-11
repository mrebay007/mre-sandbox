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
            Text("Parking Lot")
                .fontWeight(.bold)
            
        }

    }
}

struct ScoreView: View {
    
    @EnvironmentObject var shopList: ShoppingList

    var body: some View {
        Text("Score: ")
    }
}
