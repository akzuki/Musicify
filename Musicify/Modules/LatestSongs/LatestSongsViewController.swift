//
//  ViewController.swift
//  Musicify
//
//  Created by Hai Phan on 27/12/2018.
//  Copyright © 2018 Hai Phan. All rights reserved.
//

import UIKit

class LatestSongsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var latestSongsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - ViewModel
    var latestSongsViewModel: LatestSongsViewModelType = LatestSongsViewModel()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latestSongsTableView.delegate = self
        latestSongsTableView.dataSource = self
        
        latestSongsTableView.rowHeight = 200
        
        // Bind viewmodel
        bindViewModel()
    }
    
    func bindViewModel() {
        // Bind outputs
        latestSongsViewModel.latestSongsDidUpdate = { [weak self] in
            self?.latestSongsTableView.isHidden = false
            self?.latestSongsTableView.reloadData()
        }
        latestSongsViewModel.isLoading = { [weak self] isLoading in
            if isLoading {
                self?.loadingIndicator.startAnimating()
                self?.latestSongsTableView.isHidden = true
            } else {
                self?.loadingIndicator.stopAnimating()
                self?.latestSongsTableView.isHidden = false
            }
        }
        latestSongsViewModel.error = { [weak self] message in
            self?.latestSongsTableView.isHidden = true
            
            let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertViewController.addAction(cancelAction)
            
            self?.present(alertViewController, animated: true, completion: nil)
        }
        // Bind inputs
        latestSongsViewModel.loadLatestSongs()
    }
}

// MARK: - UITableViewDataSource
extension LatestSongsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestSongsViewModel.latestSongViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestSongTableViewCell") as! LatestSongTableViewCell
        
        let songViewModel = latestSongsViewModel.latestSongViewModels[indexPath.row]
        cell.configure(song: songViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LatestSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lyricsURL = latestSongsViewModel.latestSongViewModels[indexPath.row].lyricsURL
        UIApplication.shared.open(lyricsURL, options: [:], completionHandler: nil)
    }
}

