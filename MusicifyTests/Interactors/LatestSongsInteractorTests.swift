//
//  LatestSongsInteractorTests.swift
//  MusicifyTests
//
//  Created by Hai Phan on 03/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import XCTest
import Moya

@testable import Musicify

class LatestSongsInteractorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadSongSuccessfully() {
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
        let latestSongsInteractor = LatestSongsInteractor(musicifyAPIProvider: mockMusicifyAPI)
        
        // When
        var actualSongs: [Song] = []
        latestSongsInteractor.getLatestSongs(success: { (songs) in
            actualSongs = songs
        }) { (error) in
            XCTFail("There should not be any errors")
        }
        // Then
        XCTAssertEqual(actualSongs, expectedSongs)
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
        let latestSongsInteractor = LatestSongsInteractor(musicifyAPIProvider: mockMusicifyAPI)
        // When
        var actualSongs: [Song] = []
        var errorMessage: String?
        latestSongsInteractor.getLatestSongs(success: { (songs) in
            actualSongs = songs
        }) { (error) in
            errorMessage = error
        }
        // Then
        XCTAssertEqual(actualSongs, [])
        guard let error = errorMessage else {
            return XCTFail()
        }
        XCTAssertEqual(error, "Connection error")
    }
    
    func testLoadLatestSongsFailDueToInvalidJSONResponse() {
        // Invalid JSON response
        let actualSongsJSON = """
            [
                {}
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
        let latestSongsInteractor = LatestSongsInteractor(musicifyAPIProvider: mockMusicifyAPI)
        // When
        var actualSongs: [Song] = []
        var errorMessage: String?
        latestSongsInteractor.getLatestSongs(success: { (songs) in
            actualSongs = songs
        }) { (error) in
            errorMessage = error
        }
        // Then
        XCTAssertEqual(actualSongs, [])
        guard let error = errorMessage else {
            return XCTFail()
        }
        XCTAssertEqual(error, "JSON parsing error")
    }
}
