//
//  AudioDataModels.swift
//  mre-sandbox
//

import AVFoundation
import SwiftUI

// MARK: - AudioTrack
struct AudioTrack: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let artist: String
    let artworkName: String
    let url: URL
    let durationString: String
}

extension AudioTrack {
    static let sampleTracks: [AudioTrack] = [
        AudioTrack(title: "Track 1", artist: "SoundHelix", artworkName: "music.note", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!, durationString: "6:12"),
        AudioTrack(title: "Track 2", artist: "SoundHelix", artworkName: "music.mic", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3")!, durationString: "7:05"),
        AudioTrack(title: "Track 3", artist: "SoundHelix", artworkName: "guitars", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3")!, durationString: "5:44"),
        AudioTrack(title: "Track 4", artist: "SoundHelix", artworkName: "pianokeys", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3")!, durationString: "5:02"),
        AudioTrack(title: "Track 5", artist: "SoundHelix", artworkName: "headphones", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3")!, durationString: "5:53"),
        AudioTrack(title: "Track 6", artist: "SoundHelix", artworkName: "hifispeaker", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3")!, durationString: "5:42"),
        AudioTrack(title: "Track 7", artist: "SoundHelix", artworkName: "music.quarternote.3", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3")!, durationString: "7:23"),
        AudioTrack(title: "Track 8", artist: "SoundHelix", artworkName: "amplifier", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3")!, durationString: "5:56"),
    ]
}

// MARK: - AudioPlayerManager
class AudioPlayerManager: ObservableObject {
    static let shared = AudioPlayerManager()

    var player: AVPlayer?
    var timeObserverToken: Any?

    @Published var isPlaying = false
    @Published var currentTrack: AudioTrack?
    @Published var queue: [AudioTrack] = AudioTrack.sampleTracks
    @Published var currentTime: Double = 0.0
    @Published var duration: Double = 0.0
    @Published var volume: Float = 0.5 {
        didSet {
            player?.volume = volume
        }
    }

    private init() {}

    func play(track: AudioTrack) {
        if currentTrack == track && player != nil {
            play()
            return
        }

        currentTrack = track
        let playerItem = AVPlayerItem(url: track.url)
        player = AVPlayer(playerItem: playerItem)
        player?.volume = volume

        duration = 0.0
        currentTime = 0.0

        setupPeriodicTimeObserver()
        play()
    }

    func play() {
        player?.play()
        isPlaying = true
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            if player == nil, let first = queue.first {
                play(track: first)
            } else {
                play()
            }
        }
    }

    func next() {
        guard let current = currentTrack, let index = queue.firstIndex(of: current) else { return }
        let nextIndex = (index + 1) % queue.count
        play(track: queue[nextIndex])
    }

    func previous() {
        guard let current = currentTrack, let index = queue.firstIndex(of: current) else { return }
        let prevIndex = (index - 1 + queue.count) % queue.count
        play(track: queue[prevIndex])
    }

    func seek(to percentage: Double) {
        guard let player = player, let currentItem = player.currentItem, currentItem.status == .readyToPlay else { return }
        let dur = currentItem.duration.seconds
        guard dur.isFinite && dur > 0 else { return }
        
        let targetTime = dur * percentage
        let cmTime = CMTime(seconds: targetTime, preferredTimescale: 600)
        player.seek(to: cmTime)
        currentTime = targetTime
    }

    private func setupPeriodicTimeObserver() {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
            timeObserverToken = nil
        }

        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self, let currentItem = self.player?.currentItem else { return }
            self.currentTime = time.seconds
            if currentItem.status == .readyToPlay {
                self.duration = currentItem.duration.seconds
            }
        }
    }
}

// MARK: - NowPlayingView
struct NowPlayingView: View {
    @ObservedObject var manager = AudioPlayerManager.shared
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Capsule()
                .fill(Color.secondary)
                .frame(width: 40, height: 5)
                .padding()

            Spacer()

            if let track = manager.currentTrack {
                Image(systemName: track.artworkName)
                    .resizable()
                    .scaledToFit()
                    .padding(50)
                    .frame(width: 300, height: 300)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.mint.opacity(0.6), Color.blue.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(radius: 10)
                    .padding(.bottom, 30)

                VStack(spacing: 8) {
                    Text(track.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(track.artist)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }

                Spacer()

                VStack(spacing: 8) {
                    let progress = manager.duration > 0 ? manager.currentTime / manager.duration : 0.0
                    Slider(value: Binding(get: { progress }, set: { newValue in
                        manager.seek(to: newValue)
                    }), in: 0...1)
                    .accentColor(.mint)

                    HStack {
                        Text(formatTime(seconds: manager.currentTime))
                        Spacer()
                        Text(manager.duration > 0 ? formatTime(seconds: manager.duration) : track.durationString)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal, 30)

                Spacer()

                HStack(spacing: 40) {
                    Button(action: {
                        manager.previous()
                    }) {
                        Image(systemName: "backward.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.primary)
                    }

                    Button(action: {
                        manager.togglePlayPause()
                    }) {
                        Image(systemName: manager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.primary)
                    }

                    Button(action: {
                        manager.next()
                    }) {
                        Image(systemName: "forward.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.primary)
                    }
                }

                Spacer()

                HStack {
                    Image(systemName: "speaker.fill")
                    Slider(value: $manager.volume, in: 0...1)
                        .accentColor(.gray)
                    Image(systemName: "speaker.wave.3.fill")
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)

            } else {
                Text("Not Playing")
                    .font(.largeTitle)
                Spacer()
            }
        }
    }

    private func formatTime(seconds: Double) -> String {
        guard seconds.isFinite && seconds >= 0 else { return "0:00" }
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", mins, secs)
    }
}

// MARK: - AudioPage
struct AudioPage: View {
    @StateObject private var manager = AudioPlayerManager.shared
    @State private var showingNowPlaying = false

    var body: some View {
        NavigationStack {
            List(manager.queue) { track in
                HStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.mint.opacity(0.8), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 50, height: 50)
                            
                        Image(systemName: track.artworkName)
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(track.title)
                            .font(.headline)
                            .foregroundColor((manager.currentTrack == track) ? .mint : .primary)
                        Text(track.artist)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    if manager.currentTrack == track && manager.isPlaying {
                        Image(systemName: "waveform")
                            .foregroundColor(.mint)
                            .font(.headline)
                    } else {
                        Text(track.durationString)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    manager.play(track: track)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Audio")
            .safeAreaInset(edge: .bottom) {
                if manager.currentTrack != nil {
                    miniPlayerView
                }
            }
        }
        .sheet(isPresented: $showingNowPlaying) {
            NowPlayingView()
        }
    }

    var miniPlayerView: some View {
        VStack(spacing: 0) {
            let progress = manager.duration > 0 ? manager.currentTime / manager.duration : 0.0
            
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(.linear)
                .tint(.mint)
                .frame(height: 2)
            
            HStack {
                if let track = manager.currentTrack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.mint.opacity(0.8), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 40, height: 40)
                            
                        Image(systemName: track.artworkName)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }

                    VStack(alignment: .leading) {
                        Text(track.title)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text(track.artist)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.leading, 8)
                }

                Spacer()

                Button(action: {
                    manager.togglePlayPause()
                }) {
                    Image(systemName: manager.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .padding(.trailing, 16)
                
                Button(action: {
                    manager.next()
                }) {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(.thinMaterial)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showingNowPlaying = true
        }
    }
}
