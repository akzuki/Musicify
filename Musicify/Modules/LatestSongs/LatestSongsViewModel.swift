//
//  LatestSongsViewModel.swift
//  Musicify
//
//  Created by Hai Phan on 03/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import Moya

protocol LatestSongsViewModelType {
    // MARK: - Inputs
    func loadLatestSongs()
    
    // MARK: - Outputs
    var latestSongViewModels: [SongViewModel] { get }
    var latestSongsDidUpdate: (() -> Void)? { get set }
    var isLoading: ((Bool) -> Void)? { get set }
    var error: ((_ message: String) -> Void)? { get set }
}

class LatestSongsViewModel: LatestSongsViewModelType {
    // Outputs
    var latestSongViewModels: [SongViewModel] = [] {
        didSet {
            latestSongsDidUpdate?()
        }
    }
    var latestSongsDidUpdate: (() -> Void)?
    var isLoading: ((Bool) -> Void)?
    var error: ((_ message: String) -> Void)?
    
    // MARK: - Dependencies
    fileprivate let musicifyAPIProvider: MoyaProvider<MusicifyAPI>
    
    init(musicifyAPIProvider: MoyaProvider<MusicifyAPI> = MoyaProvider<MusicifyAPI>(stubClosure: MoyaProvider.delayedStub(2))) {
        self.musicifyAPIProvider = musicifyAPIProvider
    }
    
    // Inputs
    func loadLatestSongs() {
        isLoading?(true)
        musicifyAPIProvider.request(.latestSongs) { [weak self] (result) in
            switch result {
            case .success(let response):
                let data = response.data
                guard let songs = try? JSONDecoder().decode([Song].self, from: data) else {
                    self?.isLoading?(false)
                    self?.error?("JSON parsing error")
                    return
                }
                self?.isLoading?(false)
                self?.latestSongViewModels = songs.map { SongViewModel(song: $0) }
            case .failure(let error):
                self?.isLoading?(false)
                self?.error?("Connection error")
            }
        }
    }
}
