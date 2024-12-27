//
//  PhotoAssetsTests.swift
//  TajaTests
//
//  Created by Andreas Guenther on 26.12.24.
//

import Testing
import UIKit

import TestingTags

@testable import Taja

@Suite
struct PhotoAssetsTests {

    @Test(.tags(.acceptanceTest),
          arguments: PhotoAsset.allCases)
    func should_contain_all_photo_assets(photo: PhotoAsset) async throws {
        #expect(UIImage(named: photo.photoName) != nil,
                "No asset found for \(photo.photoName)")
    }
}
