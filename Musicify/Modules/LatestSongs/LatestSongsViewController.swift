//
//  ViewController.swift
//  Musicify
//
//  Created by Hai Phan on 27/12/2018.
//  Copyright © 2018 Hai Phan. All rights reserved.
//

import UIKit
import Moya

class LatestSongsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var latestSongsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    fileprivate let musicifyAPIProvider = MoyaProvider<MusicifyAPI>()
    fileprivate var latestSongs: [Song] = []
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latestSongsTableView.delegate = self
        latestSongsTableView.dataSource = self
        
        latestSongsTableView.rowHeight = 210
        
        loadLatestSongs()
    }
    
    fileprivate func loadLatestSongs() {
        startLoading()
        musicifyAPIProvider.request(.latestSongs) { [weak self] result in
            switch result {
            case .success(let response):
                let data = response.data
                guard let songs = try? JSONDecoder().decode([Song].self, from: data) else {
                    self?.stopLoading()
                    self?.showError(message: "JSON parsing error")
                    return
                }
                self?.stopLoading()
                self?.showLatestSongs(songs: songs)
            case .failure(let error):
                self?.stopLoading()
                self?.showError(message: "Connection error")
            }
        }
    }
    
    fileprivate func showLatestSongs(songs: [Song]) {
        latestSongs = songs
        latestSongsTableView.isHidden = false
        latestSongsTableView.reloadData()
    }
    
    fileprivate func startLoading() {
        loadingIndicator.startAnimating()
        latestSongsTableView.isHidden = true
    }
    
    fileprivate func stopLoading() {
        loadingIndicator.stopAnimating()
        latestSongsTableView.isHidden = false
    }
    
    fileprivate func showError(message: String) {
        latestSongsTableView.isHidden = true
        
        let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertViewController.addAction(cancelAction)
        
        present(alertViewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension LatestSongsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestSongTableViewCell") as! LatestSongTableViewCell
        let song = latestSongs[indexPath.row]
        cell.configure(song: song)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LatestSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lyricsURL = latestSongs[indexPath.row].lyricsURL
        UIApplication.shared.open(lyricsURL, options: [:], completionHandler: nil)
    }
}

