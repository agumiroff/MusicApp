//
//  Resources.swift
//  MusicApp
//
//  Created by G G on 06.12.2022.
//

import UIKit

enum Resources {
    
    enum MainFeedTable {
        static var numberOfSections: Int      = 4
        static var numberOfRowsInSection: Int = 1
        static var defaultSectionSize: Double = 60
    }
    
    enum TabBar {
        enum Titles {
            static var home     = "Home"
            static var search   = "Search"
            static var library  = "Library"
            static var settings = "Settings"
        }
        
        enum Images {
            static var home     = UIImage(systemName: "house")
            static var search   = UIImage(systemName: "magnifyingglass")
            static var library  = UIImage(systemName: "books.vertical")
            static var settings = UIImage(systemName: "gearshape")
        }
    }
    
    enum Collections {
        
        enum DefaultCellConfig {
            static var fontSize:    Double = 14
            static var cellHeight:  Double = 180
            static var cellWidth:   Double = 150
        }
        
        enum BigCellConfig {
            static var section: Int        = 1
            static var fontSize:    Double = 16
            static var cellHeight:  Double = 243
            static var cellWidth:   Double = 210
        }
        
        static var headers             = ["Trending Movies",
                                          "Popular Movies",
                                          "Top Rated",
                                          "Upcoming Movies"]
        
        static var offsetBetweenSections: Double = 60
    }
    
    enum CollectionView {
        enum SettingsFoSections {
            enum TrendingMovies {
                static var spaceBetweenItems: Double = 15
            }
            
            enum PopularMovies {
                static var spaceBetweenItems: Double = 20
            }
            
            enum TopRated {
                static var spaceBetweenItems: Double = 15
            }
            
            enum UpcomingMovies {
                static var spaceBetweenItems: Double = 15
            }
        }
    }
}
