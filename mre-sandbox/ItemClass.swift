//
//  ItemCllass State.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/10/24.
//

import Foundation

class ShoppingList: ObservableObject {
    
    @Published var itemContent = [
        Item(
            image: "Robot-1",
            itemName: "Mr. Roboto",
            price: "$199.99",
            destination: .product1
        ),
        Item(
            image: "Robot-2",
            itemName: "Jonny Five",
            price: "$399.99",
            destination: .product2
        ),
        Item(
            image: "Robot-3",
            itemName: "James Bot",
            price: "$299.99",
            destination: .product3
        ),
        Item(
            image: "Robot-4",
            itemName: "Robert Bott",
            price: "$199.99",
            destination: .product4
        ),
        Item(
            image: "Robot-5",
            itemName: "Robo Cop",
            price: "$399.99",
            destination: .product5
        ),
        Item(
            image: "Robot-6",
            itemName: "Bleep Bloop",
            price: "$299.99",
            destination: .product6
        ),
        Item(
            image: "Robot-1",
            itemName: "Mr. Roboto",
            price: "$199.99",
            destination: .product1
        ),
        Item(
            image: "Robot-2",
            itemName: "Jonny Five",
            price: "$399.99",
            destination: .product2
        ),
        Item(
            image: "Robot-3",
            itemName: "James Bot",
            price: "$299.99",
            destination: .product3
        ),
        Item(
            image: "Robot-4",
            itemName: "Robert Bott",
            price: "$199.99",
            destination: .product4
        ),
        Item(
            image: "Robot-5",
            itemName: "Robo Cop",
            price: "$399.99",
            destination: .product5
        ),
        Item(
            image: "Robot-6",
            itemName: "Bleep Bloop",
            price: "$299.99",
            destination: .product6
        ),
    ]
}

