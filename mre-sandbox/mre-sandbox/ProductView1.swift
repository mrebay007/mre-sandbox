//
//  ProductView1.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/8/24.
//

import SwiftUI

struct ProductView1: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    private let images: [String] = ["Robot-1", "Robot-2", "Robot-3", "Robot-4", "Robot-5", "Robot-6"]
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    ForEach(0..<images.count, id: \.self) { index in
                        Image(images[index])
                            .frame(width: 300, height: 468)
                            .cornerRadius(24)
                            .opacity(currentIndex == index ? 1.0 : 0.3)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 48)
                    }
                    .gesture(
                        DragGesture()
                            .onEnded({ value in
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold {
                                    withAnimation {
                                        currentIndex = max(0, currentIndex - 1)
                                    }
                                } else if value.translation.width < threshold {
                                    withAnimation {
                                        currentIndex = min(images.count - 1, currentIndex + 1)
                                    }
                                }
                                
                            })
                    )
                }
                Spacer()
                Rectangle()
                    .frame(width: 0, height: 96)
                    .foregroundColor(.clear)
                Text("Jonny Five")
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
                    print("Added item to cart")
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
