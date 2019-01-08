//
//  LatestSongsActions.swift
//  Musicify
//
//  Created by Hai Phan on 08/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import ReSwift
import Moya

let moyaProvider = MoyaProvider<MusicifyAPI>()

func fetchLatestSongs() -> Action {
    
    moyaProvider.request(.latestSongs) { (result) in
        switch result {
        case .success(let response):
            let data = response.data
            guard let songs = try? JSONDecoder().decode([Song].self, from: data) else {
                return store.dispatch(LoadLatestSongsFailure(error: "JSON parsing error"))
            }
            return store.dispatch(LoadLatestSongsSuccess(songs: songs))
        case .failure(let error):
            return store.dispatch(LoadLatestSongsFailure(error: "Connection error"))
        }
    }
    
    return LoadLatestSongsStart()
}

struct LoadLatestSongsStart: Action {
    
}

struct LoadLatestSongsSuccess: Action {
    let songs: [Song]
}

struct LoadLatestSongsFailure: Action {
    let error: String
}
