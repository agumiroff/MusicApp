//
//  TrackDetailsVIewModel.swift
//  MusicApp
//
//  Created by G G on 13.01.2023.
//

import Foundation
import AVKit



//protocol ViewModelProtocol {
//
//    var moviePoster: String { get }
//    var state: MyState { get }
//    var trackData: [TrackData.Track] { get }
//    var trackIndex: Int { get }
//    var sliderValue: Double { get }
//    var width: Double { get set }
//    var currentTime: String { get }
//    var trackDuration: String { get }
//    var musicProgress: Double { get }
//    var posterSize: Double { get }
//    var isPlaying: Bool { get }
//
//    func initPlayer()
//    func deinitPlayer()
//    func pause()
//    func play()
//    func setComposition()
//    func nextTrack()
//    func seekToPosition(currentPostition: Double, screenWidth: Double)
//    func changeSliderProgress(time: CMTime)
//    func previousTrack()
//
//}

class TrackDetailsViewModel: ObservableObject {
    
    let player: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    enum MyState {
        case start
        case loading
        case success
        case failure
    }
    
    @Published var state: MyState = .start
    @Published var movieData: MovieDataModel
    @Published var trackData: [TrackData.Track]
    @Published var trackIndex: Int = 0
    @Published var sliderValue: Double = 0
    @Published var width: Double = 0
    @Published var currentTime: String = "00:00"
    @Published var trackDuration: String = "00:00"
    @Published var musicProgress: Double = 0.0
    @Published var posterSize: Double = 350
    @Published var isPlaying: Bool = false
    var token: Any!
    let interval = CMTimeMake(value: 1, timescale: 1)
    
    
    init(movieData: MovieDataModel, trackData: [TrackData.Track], trackIndex: Int) {
        self.movieData = movieData
        self.trackData = trackData
        self.trackIndex = trackIndex
        initPlayer()
        print("init")
    }
    
    func initPlayer() {
        self.state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if let url = URL(string: trackData[trackIndex].previewUrl ?? "") {
                let playerItem = AVPlayerItem(url: url)
                player.replaceCurrentItem(with: playerItem)
                self.token = player.addPeriodicTimeObserver(forInterval: self.interval, queue: .main) {(time) in
                    self.currentTime = time.toStringTime()
                    let duration = self.player.currentItem?.duration
                    let remainedTime = (duration ?? CMTime(value: 1, timescale: 1)) - time
                    self.trackDuration = remainedTime.toStringTime()
                    self.changeSliderProgress(time: time)
                }
                
                self.state = .success
            }
            else {
                self.state = .failure
            }
        }
        
    }
    
    func deinitPlayer() {
        player.pause()
        print("deinit")
    }
    
    func play() {
        player.play()
        self.isPlaying = true
    }
    
    func pause() {
        player.pause()
        self.isPlaying = false
    }
    
    func nextTrack() {
        if trackIndex < trackData.count - 1 {
            player.pause()
            trackIndex += 1
            setComposition()
            play()
        }
    }
    
    func previousTrack() {
        if trackIndex > 0 {
            trackIndex -= 1
            setComposition()
            play()
        }
    }
    
    func setComposition() {
        if let url = URL(string: trackData[trackIndex].previewUrl ?? "") {
            let playerItem = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: playerItem)
        } else {
            self.state = .failure
        }
    }
    
    func changeSliderProgress(time: CMTime) {
        if time.seconds.isNaN { return }
        let timeInSeconds = Int(CMTimeGetSeconds(time))
        guard let currentTrack = player.currentItem else { return }
        let trackDuration = CMTimeGetSeconds(currentTrack.duration)
        let percent =  Double(timeInSeconds) / trackDuration
        let screenWidth = UIScreen.main.bounds.width * 0.97
        if percent.isNaN { return }
        musicProgress = screenWidth * percent
    }
    
    func seekToPosition(currentPostition: Double, screenWidth: Double) {
        let percent = currentPostition/screenWidth
        guard let duration = self.player.currentItem?.duration
        else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekPosition = durationInSeconds * Float64(percent)
        let roundedSeekPosition = Float64(lround(seekPosition))
        self.player.seek(to: CMTimeMakeWithSeconds(roundedSeekPosition, preferredTimescale: 1))
        self.player.play()
        self.isPlaying = true
    }
    
    func sliderMove(position: Double) {
        musicProgress = position
    }
}
