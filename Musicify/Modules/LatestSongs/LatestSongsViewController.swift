//
//  ViewController.swift
//  Musicify
//
//  Created by Hai Phan on 27/12/2018.
//  Copyright © 2018 Hai Phan. All rights reserved.
//

import UIKit
import ReSwift

class LatestSongsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var latestSongsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var songs: [Song] = []
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latestSongsTableView.delegate = self
        latestSongsTableView.dataSource = self
        
        latestSongsTableView.rowHeight = 200
        
        store.dispatch(fetchLatestSongs())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) {
            $0.select { $0.latestSongsState }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    func startLoading() {
        loadingIndicator.startAnimating()
        latestSongsTableView.isHidden = true
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
        latestSongsTableView.isHidden = false
    }
    
    func showLatestSongs(songs: [Song]) {
        self.songs = songs
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

extension LatestSongsViewController: StoreSubscriber {
    func newState(state: LatestSongsState) {
        showLatestSongs(songs: state.songs)
        
        state.loading ? startLoading() : stopLoading()
        
        if let error = state.error {
            showError(message: error)
        }
    }
}

// MARK: - UITableViewDataSource
extension LatestSongsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestSongTableViewCell") as! LatestSongTableViewCell
        let song = songs[indexPath.row]
        cell.configure(song: song)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LatestSongsViewController: UITableViewDelegate {
    
}

