//
//  SearchDetailListRepositoryTests.swift
//  CleanArchitectureiOSTests
//
//  Created by jch on 6/29/25.
//

import Foundation
import XCTest
import Combine
@testable import iOSCleanArchitecture
@testable import CoreNetwork

final class SearchDetailListRepositoryTests: XCTestCase {
    private var testCancellables: Set<AnyCancellable>!
    private var testNetworkService: TestNetworkService!
    private var testSearchDetailListRepository: SearchDetailListRepository!

    override func setUpWithError() throws {
        testCancellables = []
        testNetworkService = TestNetworkService()
        testSearchDetailListRepository = SearchDetailListRepository(networkServiceProtocol: testNetworkService)
    }
    
    override func tearDownWithError() throws {
        testCancellables = nil
        testNetworkService = nil
        testSearchDetailListRepository = nil
    }

    func testSearchDetailListRepositoryProtocol() {
        let testExpectation = expectation(description: "TestSearchDetailListRepositoryProtocol")
        
        testSearchDetailListRepository.searchDetailListRepositoryProtocol(searchKeyword: "TestKeyword")
            .sink(
                receiveCompletion: { testCompletion in
                    if case .failure(let testError) = testCompletion {
                        XCTFail("요청 실패: \(testError)")
                    }
                },
                receiveValue: { testResult in
                    XCTAssertEqual(testResult.count, 1)
                    XCTAssertEqual(testResult.first?.trackName, "Test App")
                    
                    testExpectation.fulfill()
                }
            )
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.0)
    }
}

final class TestNetworkService: NetworkServiceProtocol {
    func request<T>(_ endpoint: APIEndpoint, type: T.Type) -> AnyPublisher<T, NetworkError> where T : Decodable, T : Sendable {
        let testSearchDetailEntity = SearchDetailEntity(
            id: 1,
            trackName: "Test App",
            artistName: "Test Artist",
            artworkUrl100: nil,
            description: "This is a Test app.",
            averageUserRating: 4.5,
            userRatingCount: 123,
            screenshotUrls: nil,
            genres: nil
        )

        let testSearchDetailListEntitys = SearchDetailListEntity(resultCount: 1, results: [testSearchDetailEntity])

        if let testData = testSearchDetailListEntitys as? T {
            return Just(testData)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.decodingError)
                .eraseToAnyPublisher()
        }
    }
}
