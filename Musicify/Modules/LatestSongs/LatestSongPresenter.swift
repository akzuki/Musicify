//
//  LatestSongsPresenter.swift
//  Musicify
//
//  Created by Hai Phan on 03/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import Moya

protocol LatestSongsPresenter {
    var view: LatestSongsView? { get set }
    
    func loadLatestSongs()
    func showLyrics(forSong song: Song)
}

class LatestSongsPresenterImpl: LatestSongsPresenter {
    // MARK: - View
    weak var view: LatestSongsView?
    
    // MARK: - Dependencies
    fileprivate let latestSongsInteractor: LatestSongsInteractorProtocol
    // MARK: - Wireframe
    var wireframe: LatestSongsWireframeProtocol?
    
    init(latestSongsInteractor: LatestSongsInteractorProtocol) {
        self.latestSongsInteractor = latestSongsInteractor
    }
    
    func loadLatestSongs() {
        view?.startLoading()
        latestSongsInteractor.getLatestSongs(success: { [weak self] (songs) in
            self?.view?.stopLoading()
            self?.view?.showLatestSongs(songs: songs)
        }) { [weak self] (error) in
            self?.view?.stopLoading()
            self?.view?.showError(message: error)
        }
    }
    
    func showLyrics(forSong song: Song) {
        wireframe?.showLyrics(forSong: song)
    }
}
