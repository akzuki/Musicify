//
//  LatestSongsPresenterTests.swift
//  MusicifyTests
//
//  Created by Hai Phan on 03/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import XCTest
import Moya

@testable import Musicify

class LatestSongsPresenterTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class MockLatestSongsView: LatestSongsView {
        var didCallStartLoading = false
        var didCallStopLoading = false
        var latestSongs: [Song] = []
        var errorMessage: String? = nil
        
        func startLoading() {
            didCallStartLoading = true
        }
        
        func stopLoading() {
            didCallStopLoading = true
        }
        
        func showLatestSongs(songs: [Song]) {
            latestSongs = songs
        }
        
        func showError(message: String) {
            errorMessage = message
        }
        
        
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
        let mockLatestSongsInteractor = LatestSongsInteractor(musicifyAPIProvider: mockMusicifyAPI)
        let latestSongsPresenter = LatestSongsPresenterImpl(latestSongsInteractor: mockLatestSongsInteractor)
        let mockView = MockLatestSongsView()
        latestSongsPresenter.view = mockView
        // When
        latestSongsPresenter.loadLatestSongs()
        // Then
        
        // Assert that returned data is correct
        XCTAssertEqual(mockView.latestSongs, expectedSongs)
        // Assert that startLoading is called
        XCTAssert(mockView.didCallStartLoading)
        // Assert that stopLoading is called
        XCTAssert(mockView.didCallStopLoading)
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
        let mockLatestSongsInteractor = LatestSongsInteractor(musicifyAPIProvider: mockMusicifyAPI)
        let latestSongsPresenter = LatestSongsPresenterImpl(latestSongsInteractor: mockLatestSongsInteractor)
        let mockView = MockLatestSongsView()
        latestSongsPresenter.view = mockView
        // When
        latestSongsPresenter.loadLatestSongs()
        // Then
        
        // Assert that error message exists
        guard let errorMessage = mockView.errorMessage else {
            return XCTFail()
        }
        // Assert that error message is correct
        XCTAssertEqual(errorMessage, "Connection error")
        // Assert that startLoading is called
        XCTAssert(mockView.didCallStartLoading)
        // Assert that stopLoading is called
        XCTAssert(mockView.didCallStopLoading)
    }
}
