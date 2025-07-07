//
//  SearchDetailListUseCaseTests.swift
//  CleanArchitectureiOSTests
//
//  Created by jch on 6/29/25.
//

import Foundation
import XCTest
import Combine
@testable import iOSCleanArchitecture

final class SearchDetailListUseCaseTests: XCTestCase {
    private var testCancellables: Set<AnyCancellable>!
    private var testSearchDetailListRepository: TestSearchDetailListRepository!
    private var testSearchDetailListUseCase: SearchDetailListUseCase!

    override func setUpWithError() throws {
        testCancellables = []
        testSearchDetailListRepository = TestSearchDetailListRepository()
        testSearchDetailListUseCase = SearchDetailListUseCase(repository: testSearchDetailListRepository)
    }
    
    override func tearDownWithError() throws {
        testCancellables = nil
        testSearchDetailListRepository = nil
        testSearchDetailListUseCase = nil
    }

    func testSearchDetailListUseCaseProtocol() {
        let testExpectation = expectation(description: "TestSearchDetailListUseCaseProtocol")

        testSearchDetailListUseCase.searchDetailListUseCaseProtocol(searchKeyword: "TestKeyword")
            .sink(
                receiveCompletion: { testCompletion in
                    if case .failure(let testError) = testCompletion {
                        XCTFail("에러 발생: \(testError)")
                    }
                },
                receiveValue: { testResult in
                    XCTAssertEqual(testResult.first?.id, 123)
                    XCTAssertEqual(testResult.first?.trackName, "Test App")
                    
                    testExpectation.fulfill()
            })
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.0)
    }
}

final class TestSearchDetailListRepository: SearchDetailListRepositoryProtocol {
    func searchDetailListRepositoryProtocol(searchKeyword: String) -> AnyPublisher<[SearchDetailEntity], Error> {
        let testEntity = SearchDetailEntity(
            id: 123,
            trackName: "Test App",
            artistName: "Test Artist",
            artworkUrl100: nil,
            description: "This is a Test app",
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
