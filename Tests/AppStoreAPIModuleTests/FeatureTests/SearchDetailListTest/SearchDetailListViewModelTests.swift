//
//  SearchDetailListViewModelTests.swift
//  CleanArchitectureiOSTests
//
//  Created by jch on 6/29/25.
//

import Foundation
import XCTest
import Combine
@testable import AppStoreAPIModule

final class SearchDetailListViewModelTests: XCTestCase {
    private var testSearchDetailListUseCase: TestSearchDetailListUseCase!
    private var testSearchDetailListViewModel: SearchDetailListViewModel!
    
    private var testCancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        testSearchDetailListUseCase = TestSearchDetailListUseCase()
        testSearchDetailListViewModel = SearchDetailListViewModel(useCase: testSearchDetailListUseCase, searchKeyword: "TestKeyword")
        
        testCancellables = []
    }
    
    override func tearDownWithError() throws {
        testSearchDetailListUseCase = nil
        testSearchDetailListViewModel = nil
        
        testCancellables = nil
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

        wait(for: [testExpectation], timeout: 1.5)
    }
}

final class TestSearchDetailListUseCase: SearchDetailListUseCaseProtocol {
    func searchDetailListUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchDetailEntity], Error> {
        let testResult = SearchDetailEntity(
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
        
        return Just([testResult])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
