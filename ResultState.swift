//
//  ResultState.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}
