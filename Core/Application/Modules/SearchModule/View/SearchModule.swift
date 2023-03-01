//
//  SearchModule.swift
//  MusicApp
//
//  Created by G G on 09.12.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import UIKit

struct SearchModule: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @State var isSearchActive: Bool = false
    @State var searchCall: String = ""
    
    init(viewModel: SearchViewModel) {
        
        self.viewModel = viewModel
        
        UITableView.appearance().backgroundColor     = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1626832485, green: 0.197935462, blue: 0.2544843853, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                if !isSearchActive && searchCall.isEmpty {
                    BodyText(text: "Search", fontColor: .white, fontSize: 34)
                        .padding([.leading, .bottom], 25)
                }
                
                SearchTextField()
                
                if isSearchActive || !searchCall.isEmpty {
                    SearchResultsTable()
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func SearchTextField() -> some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Find movie", text: $searchCall){ focused in
                    focused ? withAnimation { isSearchActive.toggle() } : withAnimation { isSearchActive.toggle() }
                }
                .onChange(of: searchCall) { newValue in
                    if searchCall.isEmpty { return viewModel.movieDataArray = [] }
                    viewModel.searchMovie(movieName: searchCall)
                }
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(30)
            
            if isSearchActive {
                Button{
                    searchCall = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    BodyText(text: "Cancel", fontColor: .white, fontSize: 14)
                }
            }
        }
        .padding(EdgeInsets.init(top: 0, leading: 25, bottom: 12, trailing: 25))
    }
    
    
    @ViewBuilder
    func SearchResultsTable()->some View {
        List(viewModel.movieDataArray) {
            movie in SearchResultsTableRow(movieData: movie)
                .padding(.bottom)
                .listRowBackground(Color.clear)
        }
    }
    
    @ViewBuilder
    func SearchResultsTableRow(movieData: MovieDataModel)->some View{
        HStack {
            AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movieData.poster_path ?? "")"))
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                BodyText(text: movieData.title, fontColor: .white, fontSize: 16)
                    .padding(.bottom, 5)
                BodyText(text: movieData.overview ?? "", fontColor: .gray, fontSize: 14)
                    .lineLimit(1)
            }
            Spacer()
            Image(systemName: "ellipsis")
                .padding(.leading)
        }
        .onTapGesture {
            viewModel.router.movieDetailsPageRoute(moviesData: movieData)
        }
    }
}

struct BodyText: View {
    var text: String
    var fontColor: Color
    var fontSize: Int
    
    init(text: String, fontColor: Color, fontSize: Int) {
        self.text = text
        self.fontColor = fontColor
        self.fontSize = fontSize
    }
    
    var body: some View {
        Text(text)
            .font(.custom("Roboto-Regular", size: CGFloat(fontSize)))
            .foregroundColor(fontColor)
            .lineLimit(1)
    }
}
