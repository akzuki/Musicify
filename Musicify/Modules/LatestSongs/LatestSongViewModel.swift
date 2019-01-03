//
//  LatestSongViewModel.swift
//  Musicify
//
//  Created by Hai Phan on 03/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation

struct SongViewModel {
    let name: String
    let artist: String
    let releaseYear: String
    let thumbnailURL: URL
    let lyricsURL: URL
    
    init(song: Song) {
        name = song.name
        artist = song.artist
        releaseYear = song.releaseYear
        thumbnailURL = song.thumbnailURL
        lyricsURL = song.lyricsURL
    }
}

extension SongViewModel: Equatable {
    static func ==(lhs: SongViewModel, rhs: SongViewModel) -> Bool {
        return (
            lhs.name == rhs.name &&
            lhs.artist == rhs.artist &&
            lhs.releaseYear == rhs.releaseYear &&
            lhs.thumbnailURL == rhs.thumbnailURL &&
            lhs.lyricsURL == rhs.lyricsURL
        )
    }
}
