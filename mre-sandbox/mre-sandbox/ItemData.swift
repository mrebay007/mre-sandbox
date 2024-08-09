//
//  ItemData.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

enum Destination: String, CaseIterable {
    
    case product1
    case product2
    case product3
    case product4
    case product5
    case product6
    
    @ViewBuilder
    static func view(forSelection selection: Destination) -> some View {
        switch selection {
        case .product1:
            ProductView1()
        case .product2:
            ProductView2()
        case .product3:
            ProductView3()
        case .product4:
            ProductView4()
        case .product5:
            ProductView5()
        case .product6:
            ProductView6()
        }
    }
}

struct ItemData {
    static var itemContent = [
        Item(
            image: "Robot-1",
            itemName: "Product 1",
            price: "$19.99",
            destination: .product1
        ),
        Item(
            image: "Robot-2",
            itemName: "Product 2",
            price: "$39.99",
            destination: .product2
        ),
        Item(
            image: "Robot-3",
            itemName: "Product 3",
            price: "$29.99",
            destination: .product3
        ),
        Item(
            image: "Robot-4",
            itemName: "Product 4",
            price: "$19.99",
            destination: .product4
        ),
        Item(
            image: "Robot-5",
            itemName: "Product 5",
            price: "$39.99",
            destination: .product5
        ),
        Item(
            image: "Robot-6",
            itemName: "Product 6",
            price: "$29.99",
            destination: .product6
        ),
    ]
}
