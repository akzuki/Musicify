//
//  MusicifyAPI.swift
//  Musicify
//
//  Created by Hai Phan on 02/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import Moya

enum MusicifyAPI {
    case latestSongs
}

extension MusicifyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.myjson.com")!
    }
    
    var path: String {
        switch self {
        case .latestSongs:
            return "/bins/183jfg"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .latestSongs:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .latestSongs:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .latestSongs:
            return (
                """
                [
                    {
                        "id": 1,
                        "name": "Back To You",
                        "artist": "Selena Gomez",
                        "releaseYear": "2018",
                        "thumbnailURL": "https://i.ytimg.com/vi/VY1eFxgRR-k/maxresdefault.jpg",
                        "lyricsURL": "https://www.azlyrics.com/lyrics/selenagomez/backtoyou.html"
                    },
                    {
                        "id": 2,
                        "name": "Dance To This",
                        "artist": "Troye Sivan ft Ariana Grande",
                        "releaseYear": "2018",
                        "thumbnailURL": "https://i.ytimg.com/vi/bhxhNIQBKJI/maxresdefault.jpg",
                        "lyricsURL": "https://www.azlyrics.com/lyrics/troyesivan/dancetothis.html"
                    },
                    {
                        "id": 3,
                        "name": "Lost In Japan",
                        "artist": "Shawn Mendes",
                        "releaseYear": "2018",
                        "thumbnailURL": "https://i.ytimg.com/vi/ycy30LIbq4w/maxresdefault.jpg",
                        "lyricsURL": "https://www.azlyrics.com/lyrics/shawnmendes/lostinjapan.html"
                    },
                    {
                        "id": 4,
                        "name": "My My My!",
                        "artist": "Troye Sivan",
                        "releaseYear": "2018",
                        "thumbnailURL": "https://i.ytimg.com/vi/k5TqNsr6YuQ/maxresdefault.jpg",
                        "lyricsURL": "https://www.azlyrics.com/lyrics/troyesivan/mymymy.html"
                    }
                ]
                """
                .data(using: .utf8)!
            )
        }
    }
}
