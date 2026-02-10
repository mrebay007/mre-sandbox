//
//  AudioDemo.swift
//  mre-sandbox
//
//  Created by Eberhardt Macbook Air on 8/15/24.
//

import AVFoundation
import SwiftUI

class AudioPlayerManager: ObservableObject {
    var player: AVPlayer?
    @Published var isPlaying = false

    init() {
        let url = URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        self.player?.volume = 0.5  // Default volume
    }

    func play() {
        player?.play()
        isPlaying = true
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    func setVolume(_ volume: Float) {
        player?.volume = volume
    }
}

struct AudioDemo: View {
    @StateObject private var audioManager = AudioPlayerManager()
    @State var value: Double = 50.0  // Initialize with a default value within range
    @State private var celsius: Double = 0
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 1...100

    var body: some View {
        ScrollView {
            Spacer()
            Text("Audio Demo")
                .font(.largeTitle)
                .padding()

            Button(action: {
                if audioManager.isPlaying {
                    audioManager.pause()
                } else {
                    audioManager.play()
                }
            }) {
                Image(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            .padding()

            Text("Volume: \(Int(value))%")

            GeometryReader { gr in
                let thumbSize = gr.size.height * 0.8
                let radius = gr.size.height * 0.5
                let minValue = gr.size.width * 0.015
                let maxValue = (gr.size.width * 0.98) - thumbSize

                let scaleFactor =
                    (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
                let lower = sliderRange.lowerBound
                let sliderVal = (self.value - lower) * scaleFactor + minValue

                ZStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.gray.opacity(0.2))
                        .background(Color.white)

                    // Fill track
                    HStack {
                        RoundedRectangle(cornerRadius: radius)
                            .foregroundColor(.blue)
                            .frame(width: sliderVal + thumbSize / 2)
                        Spacer()
                    }

                    HStack {
                        Circle()
                            .foregroundColor(Color.blue)
                            .frame(width: thumbSize, height: thumbSize)
                            .offset(x: sliderVal)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { v in
                                        if abs(v.translation.width) < 0.1 {
                                            self.lastCoordinateValue = sliderVal
                                        }
                                        if v.translation.width > 0 {
                                            let nextCoordinateValue = min(
                                                maxValue,
                                                self.lastCoordinateValue + v.translation.width)
                                            self.value =
                                                ((nextCoordinateValue - minValue) / scaleFactor)
                                                + lower
                                        } else {
                                            let nextCoordinateValue = max(
                                                minValue,
                                                self.lastCoordinateValue + v.translation.width)
                                            self.value =
                                                ((nextCoordinateValue - minValue) / scaleFactor)
                                                + lower
                                        }

                                        // Update volume
                                        // Map 1...100 to 0.0...1.0
                                        let volume = Float(self.value / 100.0)
                                        audioManager.setVolume(volume)
                                    }
                            )
                        Spacer()
                    }
                }
            }
            .frame(height: 60.0)  // Reduced height for a standard slider look
            .padding()
        }
        .onAppear {
            // Sync initial volume
            let volume = Float(self.value / 100.0)
            audioManager.setVolume(volume)
        }
    }
}
