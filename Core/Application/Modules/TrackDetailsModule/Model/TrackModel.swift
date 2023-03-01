//
//  TrackModel.swift
//  MusicApp
//
//  Created by G G on 26.12.2022.
//

import Foundation



enum TrackData {
    
    case initial(Track)
    case loading
    case success(Track)
    case failure
    case play
    case pause
    
    
    struct TrackResult: Decodable {
        let resultCount: Int
        let results: [Track]
    }
    
    
    struct Track: Decodable, Identifiable {
        var id:             Int?
        var trackID:        Int?
        var artistName:     String?
        var collectionName: String?
        var trackName:      String?
        var artWorkUrl:     String?
        var previewUrl:     String?
        
        init(trackID:        Int?    = nil,
             artistName:     String? = nil,
             collectionName: String? = nil,
             trackName:      String? = nil,
             artWorkUrl:     String? = nil,
             previewUrl:     String? = nil)
        {
            
            self.trackID        = trackID
            self.artistName     = artistName
            self.collectionName = collectionName
            self.trackName      = trackName
            self.artWorkUrl     = artWorkUrl
            self.previewUrl     = previewUrl
        }
    }
    
}
