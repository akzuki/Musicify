//
//  MusicifyAPI.swift
//  Musicify
//
//  Created by Hai Phan on 02/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import Moya

enum MusicifyAPI: TargetType {
    case latestSongs
    
    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
    
    var path: String {
        switch self {
        case .latestSongs:
            return "/latestSongs"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .latestSongs:
            return .get
        }
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
                        "thumbnailURL": "https://i.ytimg.com/vi/VY1eFxgRR-k/maxresdefault.jpg"
                    },
                    {
                        "id": 2,
                        "name": "Dance To This",
                        "artist": "Troye Sivan ft Ariana Grande",
                        "releaseYear": "2018",
                        "thumbnailURL": "https://i.ytimg.com/vi/bhxhNIQBKJI/maxresdefault.jpg"
                    },
                    {
                        "id": 3,
                        "name": "Lost In Japan",
                        "artist": "Shawn Mendes",
                        "releaseYear": "2018",
                        "thumbnailURL": "https://i.ytimg.com/vi/ycy30LIbq4w/maxresdefault.jpg"
                    },
                    {
                        "id": 4,
                        "name": "My My My!",
                        "artist": "Troye Sivan",
                        "releaseYear": "2018",
                        "thumbnailURL": "https://i.ytimg.com/vi/k5TqNsr6YuQ/maxresdefault.jpg"
                    }
                ]
                """
                .data(using: .utf8)!
            )
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
}
