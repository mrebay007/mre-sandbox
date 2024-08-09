//
//  Item.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

struct Item: Identifiable, Hashable {
    var id : UUID = UUID()
    var image: String
    var itemName: String
    var price: String
    var destination: Destination
}

