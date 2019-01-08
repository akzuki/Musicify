//
//  LatestSongsReducer.swift
//  Musicify
//
//  Created by Hai Phan on 08/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import ReSwift

func latestSongsReducer(action: Action, state: LatestSongsState?) -> LatestSongsState {
    var state = state ?? LatestSongsState(songs: [], loading: false, error: nil)
    
    switch action {
    case _ as LoadLatestSongsStart:
        state.loading = true
        state.error = nil
    case let loadLatestSongsSuccess as LoadLatestSongsSuccess:
        state.loading = false
        state.songs = loadLatestSongsSuccess.songs
        state.error = nil
    case let loadLatestSongsFailure as LoadLatestSongsFailure:
        state.loading = false
        state.error = loadLatestSongsFailure.error
    default: break
    }
    
    return state
}
