//
//  LatestSongsPresenter.swift
//  Musicify
//
//  Created by Hai Phan on 02/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import Moya

protocol LatestSongPresenter {
    var view: LatestSongsView? { get set }
    
    func loadLatestSongs()
}

class LatestSongPresenterImpl: LatestSongPresenter {
    // MARK: - View
    weak var view: LatestSongsView?
    
    // MARK: - Dependencies
    fileprivate let musicifyAPIProvider: MoyaProvider<MusicifyAPI>
    
    init(musicifyAPIProvider: MoyaProvider<MusicifyAPI> = MoyaProvider<MusicifyAPI>()) {
        self.musicifyAPIProvider = musicifyAPIProvider
    }
    
    func loadLatestSongs() {
        view?.startLoading()
        musicifyAPIProvider.request(.latestSongs) { [weak self] (result) in
            switch result {
            case .success(let response):
                let data = response.data
                guard let songs = try? JSONDecoder().decode([Song].self, from: data) else {
                    self?.view?.stopLoading()
                    self?.view?.showError(message: "JSON parsing error")
                    return
                }
                self?.view?.stopLoading()
                self?.view?.showLatestSongs(songs: songs)
            case .failure(let error):
                self?.view?.stopLoading()
                self?.view?.showError(message: "Connection error")
            }
        }
    }
}
