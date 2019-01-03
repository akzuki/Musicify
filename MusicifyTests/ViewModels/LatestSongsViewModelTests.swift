//
//  LatestSongsViewModel.swift
//  MusicifyTests
//
//  Created by Hai Phan on 03/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import XCTest
import Moya

@testable import Musicify

class LatestSongsViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadLatestSongsSuccessfully() {
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
        
        let expectedSongViewModels = expectedSongs.map { SongViewModel(song: $0) }
        
        let actualSongsJSON = """
            [
                {
                    "id": 1,
                    "name": "Back To You",
                    "artist": "Selena Gomez",
                    "releaseYear": "2018",
                    "thumbnailURL": "https://i.ytimg.com/vi/VY1eFxgRR-k/maxresdefault.jpg",
                    "lyricsURL": "https://www.azlyrics.com/lyrics/selenagomez/backtoyou.html"
                },
                {
                    "id": 2,
                    "name": "Dance To This",
                    "artist": "Troye Sivan ft Ariana Grande",
                    "releaseYear": "2018",
                    "thumbnailURL": "https://i.ytimg.com/vi/bhxhNIQBKJI/maxresdefault.jpg",
                    "lyricsURL": "https://www.azlyrics.com/lyrics/troyesivan/dancetothis.html"
                }
            ]
        """
        
        let customEndpointClosure = { (target: MusicifyAPI) -> Endpoint in
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { () -> EndpointSampleResponse in
                    return .networkResponse(200, actualSongsJSON.data(using: .utf8)!)
            },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
        // Given
        let mockMusicifyAPI = MoyaProvider<MusicifyAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        let latestSongsViewModel = LatestSongsViewModel(musicifyAPIProvider: mockMusicifyAPI)
        // When
        var isLoadingArray: [Bool] = []
        var didCallLatestSongsDidUpdate = false
        latestSongsViewModel.isLoading = { isLoadingArray.append($0) }
        latestSongsViewModel.error = { message in
            XCTFail("There should NOT be any errors")
        }
        latestSongsViewModel.latestSongsDidUpdate = { didCallLatestSongsDidUpdate = true }
        
        latestSongsViewModel.loadLatestSongs()
        // Then
        XCTAssert(didCallLatestSongsDidUpdate)
        XCTAssertEqual(latestSongsViewModel.latestSongViewModels, expectedSongViewModels)
        XCTAssertEqual(isLoadingArray, [true, false])
    }
    
    func testLoadLatestSongsFailDueToNetworkError() {
        let customEndpointClosure = { (target: MusicifyAPI) -> Endpoint in
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { () -> EndpointSampleResponse in
                    return .networkError(NSError())
            },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
        // Given
        let mockMusicifyAPI = MoyaProvider<MusicifyAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        let latestSongsViewModel = LatestSongsViewModel(musicifyAPIProvider: mockMusicifyAPI)
        // When
        var isLoadingArray: [Bool] = []
        var didCallLatestSongsDidUpdate = false
        latestSongsViewModel.isLoading = { isLoadingArray.append($0) }
        latestSongsViewModel.error = { message in
            // Assert that error message is correct
            XCTAssertEqual(message, "Connection error")
        }
        latestSongsViewModel.latestSongsDidUpdate = { didCallLatestSongsDidUpdate = true }
        
        latestSongsViewModel.loadLatestSongs()
        // Then
        XCTAssertFalse(didCallLatestSongsDidUpdate)
        XCTAssertEqual(latestSongsViewModel.latestSongViewModels, [])
        XCTAssertEqual(isLoadingArray, [true, false])
    }
}
