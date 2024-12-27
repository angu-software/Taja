//
//  PhotoAsset.swift
//  Taja
//
//  Created by Andreas Guenther on 27.12.24.
//

import Foundation

enum PhotoAsset: String, CaseIterable {

    case photo01
    case photo02

    var photoName: String {
        return rawValue
    }
}
