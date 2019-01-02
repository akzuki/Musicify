//
//  ViewController.swift
//  Musicify
//
//  Created by Hai Phan on 27/12/2018.
//  Copyright © 2018 Hai Phan. All rights reserved.
//

import UIKit

protocol LatestSongsView: class {
    func startLoading()
    func stopLoading()
    func showLatestSongs(songs: [Song])
    func showError(message: String)
}

class LatestSongsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var latestSongsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Presenter
    var latestSongsPresenter: LatestSongPresenter = LatestSongPresenterImpl()
    
    var latestSongs: [Song] = []
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latestSongsTableView.delegate = self
        latestSongsTableView.dataSource = self
        
        latestSongsTableView.rowHeight = 200
        
        latestSongsPresenter.view = self
        latestSongsPresenter.loadLatestSongs()
    }
}

// MARK: - LatestSongsView
extension LatestSongsViewController: LatestSongsView {
    func startLoading() {
        loadingIndicator.startAnimating()
        latestSongsTableView.isHidden = true
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
        latestSongsTableView.isHidden = false
    }
    
    func showLatestSongs(songs: [Song]) {
        latestSongs = songs
        latestSongsTableView.isHidden = false
        latestSongsTableView.reloadData()
    }
    
    func showError(message: String) {
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

