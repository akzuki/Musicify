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
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latestSongsTableView.delegate = self
        latestSongsTableView.dataSource = self
        
        latestSongsTableView.rowHeight = 200
    }
}

// MARK: - UITableViewDataSource
extension LatestSongsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestSongTableViewCell") as! LatestSongTableViewCell
        
        let song = Song(
            id: 1,
            name: "Back To You",
            artist: "Selena Gomez",
            releaseYear: "2018",
            thumbnailURL: URL(string: "https://i.ytimg.com/vi/VY1eFxgRR-k/maxresdefault.jpg")!
        )
        
        cell.configure(song: song)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LatestSongsViewController: UITableViewDelegate {
    
}

