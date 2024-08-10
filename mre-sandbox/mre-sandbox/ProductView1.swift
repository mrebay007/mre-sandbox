//
//  ProductView1.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

struct ProductView1: View {
    
    @Namespace private var animation
    
    var body: some View {
        Text("ProductView1")
            .font(.largeTitle)
        
        Image("Robot-1")
            .frame(width: 512, height: 512)
    }
}

#Preview {
    ProductView1()
}
