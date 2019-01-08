//
//  AppReducer.swift
//  Musicify
//
//  Created by Hai Phan on 08/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(latestSongsState: latestSongsReducer(action: action, state: state?.latestSongsState))
}
