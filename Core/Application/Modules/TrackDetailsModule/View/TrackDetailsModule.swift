//
//  DetailsModule.swift
//  MusicApp
//
//  Created by G G on 22.12.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit

struct TrackDetailsModule: View {
    @ObservedObject var viewModel: TrackDetailsViewModel
    
    //MARK: Main View
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1626832485, green: 0.197935462, blue: 0.2544843853, alpha: 1))
                .edgesIgnoringSafeArea(.all)
                .onDisappear{
                    viewModel.deinitPlayer()
                }
            switch viewModel.state {
            case .start :
                Text("Start")
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            case .success:
                Text("success")
                VStack(alignment: .center) {
                    BodyText(text: viewModel.movieData.title, fontColor: .white, fontSize: 24)
                        .padding()
                    moviePoster()
                    compositionTitleRow()
                    playerSlider()
                    PlayerButtons()
                }
                .padding()
            case .failure:
                Text("failure")
            }
        }
    }
    
    //MARK: Movie poster
    @ViewBuilder
    func moviePoster() -> some View {
        let posterSize = viewModel.isPlaying ? viewModel.posterSize : viewModel.posterSize * 0.9
        VStack {
            AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.movieData.poster_path ?? "")" ))
                .resizable()
                .renderingMode(.original)
                .scaledToFill()
                .frame(width: posterSize, height: posterSize)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 40, height: 40)))
                .padding(.bottom, 31)
        }
        .frame(width: viewModel.posterSize, height: viewModel.posterSize)
    }
    
    //MARK: Composition name and authors name, like and edit buttons
    @ViewBuilder
    func compositionTitleRow() -> some View {
        HStack {
            VStack (alignment: .leading) {
                BodyText(text: viewModel.trackData[viewModel.trackIndex].trackName ?? "", fontColor: .white, fontSize: 24)
                BodyText(text: viewModel.trackData[viewModel.trackIndex].artistName ?? "", fontColor: .gray, fontSize: 18)
                    .padding(.bottom, 15)
            }
            Spacer()
            Image(systemName: "heart")
                .font(.title)
                .foregroundColor(.gray)
                .padding(.trailing)
            Image(systemName: "ellipsis")
                .font(.title)
                .foregroundColor(.gray)
        }
    }
    
    
    // MARK: Slider and play time
    @ViewBuilder
    func playerSlider() -> some View {
        VStack {
            GeometryReader { proxy in
                let frameWidth = proxy.size.width
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.white.opacity(0.1)).frame(width: frameWidth, height: 4)
                    HStack(spacing: 0) {
                        Rectangle().fill(Color.yellow).frame(height: 4)
                        Circle().fill(Color.yellow).frame(width: 16, height: 16)
                    }
                    .frame(width: viewModel.musicProgress)
                }
                .gesture(DragGesture()
                    .onChanged({ value in
                        viewModel.pause()
                        let position = value.location.x > 0 ? value.location.x : 0
                        viewModel.sliderMove(position: position)
                        
                    }).onEnded({ value in
                        viewModel.seekToPosition(currentPostition: Double(value.location.x), screenWidth: frameWidth)
                    }))
            }
            .frame(height: 0)
            .padding(.bottom, 25)
            
            //MARK: Playtime
            HStack {
                BodyText(text: "\(viewModel.currentTime)", fontColor: .white, fontSize: 14)
                Spacer()
                BodyText(text: "\(viewModel.trackDuration)", fontColor: .white, fontSize: 14)
            }
            .padding(.bottom, 31)
        }
    }
    
    @ViewBuilder
    func PlayerButtons()->some View {
        HStack(spacing: UIScreen.main.bounds.width/6) {
            //backward button
            Button (action: {
                viewModel.previousTrack()
            }, label: {
                Image(systemName: "backward.fill")
                    .font(.title)
                    .foregroundColor(.white)
            })
            //pause/play button
            Button (action: {
                if viewModel.isPlaying {
                    viewModel.pause()
                } else {
                    viewModel.play()
                }
            }, label: {
                Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.custom("", size: 75))
                    .foregroundColor(.yellow)
            })
            //forward button
            Button (action: {
                viewModel.nextTrack()
            }, label: {
                Image(systemName: "forward.fill")
                    .font(.title)
                    .foregroundColor(.white)
                
            })
        }
    }
} //View

