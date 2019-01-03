//
//  LatestSongsInteractor.swift
//  Musicify
//
//  Created by Hai Phan on 03/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import Moya

protocol LatestSongsInteractorProtocol {
    func getLatestSongs(success: (([Song]) -> Void)?, error: ((String) -> Void)?)
}

class LatestSongsInteractor: LatestSongsInteractorProtocol {
    // MARK: - Dependencies
    fileprivate let musicifyAPIProvider: MoyaProvider<MusicifyAPI>
    
    init(musicifyAPIProvider: MoyaProvider<MusicifyAPI> = MoyaProvider<MusicifyAPI>()) {
        self.musicifyAPIProvider = musicifyAPIProvider
    }
    
    func getLatestSongs(success: ((_ songs: [Song]) -> Void)?, error: ((_ errorMessage: String) -> Void)?) {
        musicifyAPIProvider.request(.latestSongs) { (result) in
            switch result {
            case .success(let response):
                let data = response.data
                guard let songs = try? JSONDecoder().decode([Song].self, from: data) else {
                    error?("JSON parsing error")
                    return
                }
                success?(songs)
            case .failure:
                error?("Connection error")
            }
        }
    }
}
