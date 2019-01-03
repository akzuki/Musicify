//
//  LatestSongsWireframe.swift
//  Musicify
//
//  Created by Hai Phan on 03/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import Moya

protocol LatestSongsWireframeProtocol: class {
    func showLyrics(forSong song: Song)
}

class LatestSongsWireframe: LatestSongsWireframeProtocol {
    func showLyrics(forSong song: Song) {
        let lyricsURL = song.lyricsURL
        UIApplication.shared.open(lyricsURL, options: [:], completionHandler: nil)
    }
    
    class func createLatestSongsModule() -> UIViewController {
        let interactor = LatestSongsInteractor()
        let presenter = LatestSongsPresenterImpl(latestSongsInteractor: interactor)
        presenter.wireframe = LatestSongsWireframe()
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LatestSongsViewController") as! LatestSongsViewController
        viewController.latestSongsPresenter = presenter
        return viewController
    }
}
