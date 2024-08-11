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
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 20.0))
                    .lineSpacing(6.0)
                    .frame(maxWidth: UIScreen.main.bounds.width - 96)
                Spacer()
            }
        }
        .safeAreaInset(edge: .bottom) {
            Divider()
            HStack {
                Button("ADD TO CART") {
                    print("Button pressed!")
                }
                .padding(.horizontal, 28)
                .padding(.vertical, 16)
                .fontWeight(.bold)
                .font(Font.system(size: 14.0, weight: .bold, design: .rounded))
                .background(Color.mint)
                .clipShape(Capsule())
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width, height: 64.0)
            }
            .background(Color.black.opacity(0.7))
            

        }
        .frame(width: 512)


    }
}

#Preview {
    ProductView1()
}
