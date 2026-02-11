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

    init(url: URL) {
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

struct AudioTrackRow: View {
    let title: String
    let url: URL
    @StateObject private var audioManager: AudioPlayerManager
    @State var value: Double = 50.0
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 1...100

    init(title: String, url: URL) {
        self.title = title
        self.url = url
        _audioManager = StateObject(wrappedValue: AudioPlayerManager(url: url))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            HStack {
                Button(action: {
                    if audioManager.isPlaying {
                        audioManager.pause()
                    } else {
                        audioManager.play()
                    }
                }) {
                    Image(
                        systemName: audioManager.isPlaying
                            ? "pause.circle.fill" : "play.circle.fill"
                    )
                    .resizable()
                    .frame(width: 44, height: 44)  // Slightly smaller for list
                }
                .padding(.leading)

                Text("\(Int(value))%")
                    .frame(width: 40)

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
                                            let volume = Float(self.value / 100.0)
                                            audioManager.setVolume(volume)
                                        }
                                )
                            Spacer()
                        }
                    }
                }
                .frame(height: 40.0)
                .padding(.trailing)
            }
            .padding(.bottom)
        }
        .onAppear {
            let volume = Float(self.value / 100.0)
            audioManager.setVolume(volume)
        }
    }
}

struct AudioDemo: View {
    // 5 sample tracks
    let tracks: [(title: String, url: URL)] = [
        ("Track 1", URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!),
        ("Track 2", URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3")!),
        ("Track 3", URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3")!),
        ("Track 4", URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3")!),
        ("Track 5", URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3")!),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer()
                Text("Audio Demo")
                    .font(.largeTitle)
                    .padding()

                ForEach(0..<tracks.count, id: \.self) { index in
                    AudioTrackRow(title: tracks[index].title, url: tracks[index].url)
                    Divider()
                }
            }
        }
        .padding(.bottom)
    }
}
