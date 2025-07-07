//
//  SearchDetailTests.swift
//  CleanArchitectureiOSTests
//
//  Created by jch on 6/29/25.
//

import Foundation
import XCTest
import Combine
import SwiftUI
@testable import iOSCleanArchitecture

final class SearchDetailViewModelTests: XCTestCase {
    private var testSearchDetailViewModel: SearchDetailViewModel!

    override func setUpWithError() throws {
        let testEntity = SearchDetailEntity(
            id: 12345,
            trackName: "테스트 앱",
            artistName: "테스트 개발자",
            artworkUrl100: nil,
            description: "이것은 테스트 설명입니다.",
            averageUserRating: 4.5,
            userRatingCount: 100,
            screenshotUrls: nil,
            genres: ["유틸리티"]
        )
        
        testSearchDetailViewModel = SearchDetailViewModel(entity: testEntity)
    }

    override func tearDownWithError() throws {
        testSearchDetailViewModel = nil
    }

    func testSearchDetail() {
        XCTAssertEqual(testSearchDetailViewModel.searchDetailEntity?.id, 12345)
        XCTAssertEqual(testSearchDetailViewModel.searchDetailEntity?.trackName, "테스트 앱")
        XCTAssertEqual(testSearchDetailViewModel.searchDetailEntity?.artistName, "테스트 개발자")
        XCTAssertEqual(testSearchDetailViewModel.searchDetailEntity?.description, "이것은 테스트 설명입니다.")
        XCTAssertEqual(testSearchDetailViewModel.searchDetailEntity?.averageUserRating, 4.5)
        XCTAssertEqual(testSearchDetailViewModel.searchDetailEntity?.userRatingCount, 100)
        XCTAssertEqual(testSearchDetailViewModel.searchDetailEntity?.genres, ["유틸리티"])
    }
}
