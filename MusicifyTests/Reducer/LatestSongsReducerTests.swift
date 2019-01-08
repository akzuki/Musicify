//
//  LatestSongsReducerTests.swift
//  MusicifyTests
//
//  Created by Hai Phan on 08/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import XCTest
import Moya
import ReSwift

@testable import Musicify

class LatestSongsReducerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadSongsStartAction() {
        let state = LatestSongsState(songs: [], loading: false, error: nil)
        let action = LoadLatestSongsStart()
        
        let newState = latestSongsReducer(action: action, state: state)
        
        XCTAssertEqual(newState.error, nil)
        XCTAssertEqual(newState.songs, [])
        XCTAssertEqual(newState.loading, true)
    }
    
    func testLoadSongsSuccessAction() {
        let expectedSongs = [
            Song(
                id: 1,
                name: "Back To You",
                artist: "Selena Gomez",
                releaseYear: "2018",
                thumbnailURL: URL(string: "https://i.ytimg.com/vi/VY1eFxgRR-k/maxresdefault.jpg")!,
                lyricsURL: URL(string: "https://www.azlyrics.com/lyrics/selenagomez/backtoyou.html")!
            ),
            Song(
                id: 2,
                name: "Dance To This",
                artist: "Troye Sivan ft Ariana Grande",
                releaseYear: "2018",
                thumbnailURL: URL(string: "https://i.ytimg.com/vi/bhxhNIQBKJI/maxresdefault.jpg")!,
                lyricsURL: URL(string: "https://www.azlyrics.com/lyrics/troyesivan/dancetothis.html")!
            )
        ]
        
        let state = LatestSongsState(songs: [], loading: false, error: nil)
        let action = LoadLatestSongsSuccess(songs: expectedSongs)
        
        let newState = latestSongsReducer(action: action, state: state)
        
        XCTAssertEqual(newState.error, nil)
        XCTAssertEqual(newState.songs, expectedSongs)
        XCTAssertEqual(newState.loading, false)
    }
    
    func testLoadSongsFailureAction() {
        let state = LatestSongsState(songs: [], loading: false, error: nil)
        let action = LoadLatestSongsFailure(error: "JSON parsing error")
        
        let newState = latestSongsReducer(action: action, state: state)
        
        XCTAssertEqual(newState.error, "JSON parsing error")
        XCTAssertEqual(newState.songs, [])
        XCTAssertEqual(newState.loading, false)
    }
}
