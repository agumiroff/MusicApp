//
//  Details.swift
//  MusicApp
//
//  Created by G G on 23.12.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import UIKit

struct MovieDetailsModule: View{
    @ObservedObject var viewModel: MovieDetailsViewModel
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            GeometryReader {
                let size = $0.size
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        Poster(size: size)
                        Tracks()
                            .background(Color.black)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func Poster(size: CGSize) ->some View {
        let height = size.height * 0.5
        
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            
            ZStack {
                AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.movieData.poster_path ?? "")"))
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1.2), contentMode: .fill)
                    .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                    .clipped()
                    .offset(y: -minY)
                
                LinearGradient(colors: [.black.opacity(0),
                                        .black.opacity(0.3),
                                        .black.opacity(0.6),
                                        .black.opacity(0.8),
                                        .black.opacity(1),
                                        .black.opacity(1)],
                               startPoint: .top,
                               endPoint: .bottom)
                BodyText(text: viewModel.movieData.title , fontColor: .white, fontSize: 34)
                    .offset(y: minY)
                    .opacity(minY/30)
            }
        }
        .frame(height: height)
    }
    
    @ViewBuilder
    func Tracks() -> some View {
        ForEach(viewModel.trackData.indices, id: \.self) {index in
            HStack{
                Text("\(index + 1)")
                    .padding(.trailing)
                    .font(.callout)
                    .foregroundColor(.white)
                    .frame(width: 40)
                VStack(alignment: .leading) {
                    BodyText(text: viewModel.trackData[index].trackName ?? "", fontColor: .white, fontSize: 18)
                        .padding(.bottom, 5)
                    BodyText(text: viewModel.trackData[index].artistName ?? "", fontColor: .gray, fontSize: 18)
                }
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
            }
            .background(Color.black)
            .onTapGesture {
                viewModel.selectTrack(index: index)
                self.isPresented.toggle()
            }
            .padding()
        }
        .sheet(isPresented: $isPresented) {
            viewModel.router.trackDetailsModule(trackData: viewModel.trackData,
                                                movieData: viewModel.movieData,
                                                trackIndex: viewModel.selectedTrack)
        }
    }
}

