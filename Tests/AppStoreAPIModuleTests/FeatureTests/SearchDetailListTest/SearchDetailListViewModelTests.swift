//
//  SearchDetailListViewModelTests.swift
//  CleanArchitectureiOSTests
//
//  Created by jch on 6/29/25.
//

import Foundation
import XCTest
import Combine
import SwiftUI
@testable import iOSCleanArchitecture

final class SearchDetailListViewModelTests: XCTestCase {
    private var testCancellables: Set<AnyCancellable>!
    private var testSearchDetailListUseCase: TestSearchDetailListUseCase!
    private var testSearchDetailListViewModel: SearchDetailListViewModel!

    override func setUpWithError() throws {
        testCancellables = []
        testSearchDetailListUseCase = TestSearchDetailListUseCase()
        testSearchDetailListViewModel = SearchDetailListViewModel(useCase: testSearchDetailListUseCase, searchKeyword: "TestKeyword")
    }
    
    override func tearDownWithError() throws {
        testCancellables = nil
        testSearchDetailListUseCase = nil
        testSearchDetailListViewModel = nil
    }

    func testSearchDetailList() {
        let testExpectation = expectation(description: "TestSearchDetailList")

        testSearchDetailListViewModel.$searchDetailEntitys
            .dropFirst()
            .sink { testResults in
                XCTAssertEqual(testResults.count, 1)
                XCTAssertEqual(testResults.first?.trackName, "Test App")
                
                testExpectation.fulfill()
            }
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.0)
    }
}

final class TestSearchDetailListUseCase: SearchDetailListUseCaseProtocol {
    func searchDetailListUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchDetailEntity], Error> {
        let testEntity = SearchDetailEntity(
            id: 1,
            trackName: "Test App",
            artistName: "Test Artist",
            artworkUrl100: nil,
            description: "This is a test description",
            averageUserRating: 4.5,
            userRatingCount: 1000,
            screenshotUrls: [],
            genres: ["Utilities"]
        )
        
        return Just([testEntity])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
