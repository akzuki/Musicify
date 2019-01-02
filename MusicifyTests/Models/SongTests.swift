//
//  SongTests.swift
//  MusicifyTests
//
//  Created by Hai Phan on 02/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import XCTest
@testable import Musicify

class SongTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParsingJSONReturnsCorrectSong() {
        // Given
        let expectedSong = Song(
                                id: 1,
                                name: "Back To You",
                                artist: "Selena Gomez",
                                releaseYear: "2018",
                                thumbnailURL: URL(string: "https://i.ytimg.com/vi/VY1eFxgRR-k/maxresdefault.jpg")!
                            )
        
        let actualSongJSON = """
            {
                "id": 1,
                "name": "Back To You",
                "artist": "Selena Gomez",
                "releaseYear": "2018",
                "thumbnailURL": "https://i.ytimg.com/vi/VY1eFxgRR-k/maxresdefault.jpg"
            }
        """
        
        // When
        guard let actualSong = try? JSONDecoder().decode(Song.self, from: actualSongJSON.data(using: .utf8)!) else {
            return XCTFail("Parse JSON failed")
        }
        
        // Then
        XCTAssertEqual(actualSong, expectedSong)
    }
    
    func testParsingJSONReturnsCorrectListOfSongs() {
        // Given
        let expectedSongs = [
            Song(
                id: 1,
                name: "Back To You",
                artist: "Selena Gomez",
                releaseYear: "2018",
                thumbnailURL: URL(string: "https://i.ytimg.com/vi/VY1eFxgRR-k/maxresdefault.jpg")!
            ),
            Song(
                id: 2,
                name: "Dance To This",
                artist: "Troye Sivan ft Ariana Grande",
                releaseYear: "2018",
                thumbnailURL: URL(string: "https://i.ytimg.com/vi/bhxhNIQBKJI/maxresdefault.jpg")!
            )
        ]
        
        let actualSongsJSON = """
            [
                {
                    "id": 1,
                    "name": "Back To You",
                    "artist": "Selena Gomez",
                    "releaseYear": "2018",
                    "thumbnailURL": "https://i.ytimg.com/vi/VY1eFxgRR-k/maxresdefault.jpg"
                },
                {
                    "id": 2,
                    "name": "Dance To This",
                    "artist": "Troye Sivan ft Ariana Grande",
                    "releaseYear": "2018",
                    "thumbnailURL": "https://i.ytimg.com/vi/bhxhNIQBKJI/maxresdefault.jpg"
                }
            ]
        """
        
        // When
        guard let actualSongs = try? JSONDecoder().decode([Song].self, from: actualSongsJSON.data(using: .utf8)!) else {
            return XCTFail("Parse JSON failed")
        }
        
        // Then
        XCTAssertEqual(actualSongs, expectedSongs)
    }

}
