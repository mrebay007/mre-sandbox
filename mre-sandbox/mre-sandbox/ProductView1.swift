//
//  ProductView1.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

struct ProductView1: View {
    

    
    var body: some View {
        ScrollView {
            VStack {
                Image("Robot-1")
                    .frame(width: UIScreen.main.bounds.width)
                    .scaledToFill()
                
                Text("Robot Title")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.mint)
                Text("$199.99")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Divider()
                Button("ADD TO CART") {
                    print("Button pressed!")
                }
                .padding(.horizontal, 26)
                .padding(.vertical, 14)
                .fontWeight(.bold)
                .font(Font.system(size: 14.0, weight: .bold, design: .rounded))
                .background(Color.mint)
                .clipShape(Capsule())
                .foregroundColor(.black)
            }
        }


    }
}

#Preview {
    ProductView1()
}
