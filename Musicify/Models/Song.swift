//
//  Song.swift
//  Musicify
//
//  Created by Hai Phan on 02/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation

struct Song: Codable {
    let id: Int
    let name: String
    let artist: String
    let releaseYear: String
    let thumbnailURL: URL
}

extension Song: Equatable {
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return (
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.artist == rhs.artist &&
            lhs.releaseYear == rhs.releaseYear &&
            lhs.thumbnailURL == rhs.thumbnailURL
        )
    }
}
