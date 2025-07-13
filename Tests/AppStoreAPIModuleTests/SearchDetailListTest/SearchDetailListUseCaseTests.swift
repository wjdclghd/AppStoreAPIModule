//
//  SearchDetailListUseCaseTests.swift
//  CleanArchitectureiOSTests
//
//  Created by jch on 6/29/25.
//

import Foundation
import XCTest
import Combine
@testable import AppStoreAPIModule

final class SearchDetailListUseCaseTests: XCTestCase {
    private var testSearchDetailListRepository: TestSearchDetailListRepository!
    private var testSearchDetailListUseCase: SearchDetailListUseCase!
    
    private var testCancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        testSearchDetailListRepository = TestSearchDetailListRepository()
        testSearchDetailListUseCase = SearchDetailListUseCase(repository: testSearchDetailListRepository)
        
        testCancellables = []
    }
    
    override func tearDownWithError() throws {
        testSearchDetailListRepository = nil
        testSearchDetailListUseCase = nil
        
        testCancellables = nil
    }

    func testSearchDetailListUseCaseProtocol() {
        let testExpectation = expectation(description: "TestSearchDetailListUseCaseProtocol")

        testSearchDetailListUseCase.searchDetailListUseCaseProtocol(searchKeyword: "TestSearchDetilListKeyword")
            .sink(
                receiveCompletion: { testCompletion in
                    if case .failure(let testError) = testCompletion {
                        XCTFail("TestError: \(testError)")
                    }
                },
                receiveValue: { testResult in
                    XCTAssertEqual(testResult.first?.id, 1)
                    XCTAssertEqual(testResult.first?.trackName, "TestSearchDetilListKeyword")
                    
                    testExpectation.fulfill()
            })
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
    }
    
    func testSearchDetailListUseCaseProtocolEmpty() {
        let testExpectation = expectation(description: "TestSearchDetailListUseCaseProtocolEmpty")

        testSearchDetailListUseCase.searchDetailListUseCaseProtocol(searchKeyword: " ")
            .sink(
                receiveCompletion: { testCompletion in
                    if case .failure(let testError) = testCompletion {
                        XCTFail("TestError: \(testError)")
                    }
                },
                receiveValue: { testResults in
                    XCTAssertTrue(testResults.isEmpty)
                
                    testExpectation.fulfill()
            })
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
    }
}

final class TestSearchDetailListRepository: SearchDetailListRepositoryProtocol {
    func searchDetailListRepositoryProtocol(searchKeyword: String) -> AnyPublisher<[SearchDetailEntity], Error> {
        let testEntity = SearchDetailEntity(
            id: 1,
            trackName: "TestSearchDetilListKeyword",
            artistName: "Test Artist",
            artworkUrl100: nil,
            description: nil,
            averageUserRating: nil,
            userRatingCount: nil,
            screenshotUrls: nil,
            genres: nil
        )
        
        return Just([testEntity])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
