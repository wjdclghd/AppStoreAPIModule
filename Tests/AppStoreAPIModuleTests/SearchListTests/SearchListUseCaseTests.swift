//
//  SearchListUseCaseTests.swift
//  CleanArchitectureiOSTests
//
//  Created by jch on 6/29/25.
//

import Foundation
import XCTest
import Combine
@testable import AppStoreAPIModule

final class SearchListUseCaseTests: XCTestCase {
    private var testCancellables: Set<AnyCancellable>!
    private var testSearchListRepository: TestSearchListRepository!
    private var testSearchListUseCase: SearchListUseCase!

    override func setUpWithError() throws {
        testCancellables = []
        testSearchListRepository = TestSearchListRepository()
        testSearchListUseCase = SearchListUseCase(repository: testSearchListRepository)
    }

    override func tearDownWithError() throws {
        testCancellables = nil
        testSearchListRepository = nil
        testSearchListUseCase = nil
    }
    
    func testInsertUseCaseProtocol() {
        let testExpectation = expectation(description: "TestInsertUseCaseProtocol")
        
        testSearchListRepository.testRepositoryEntitys = []
        testSearchListRepository.insertCalled = false

        testSearchListUseCase.insertUseCaseProtocol(searchKeyword: "TestSearchKeyword")
            .sink(
                receiveCompletion: { _ in
                    testExpectation.fulfill()
                },
                receiveValue: {
                    
                }
            )
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
        
        XCTAssertTrue(testSearchListRepository.insertCalled)
    }
    
    func testInsertUseCaseProtocolDuplicate() {
        let testExpectation = expectation(description: "TestInsertUseCaseProtocolDuplicate")

        testSearchListRepository.testRepositoryEntitys = [SearchListEntity(searchKeyword: "DuplicateSearchKeyword")]
        testSearchListRepository.insertCalled = false

        testSearchListUseCase.insertUseCaseProtocol(searchKeyword: "DuplicateSearchKeyword")
            .sink(
                receiveCompletion: { _ in
                    testExpectation.fulfill()
                },
                receiveValue: {
                    
                }
            )
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
        
        XCTAssertFalse(testSearchListRepository.insertCalled)
    }
    
    func testUpdateUseCaseProtocol() {
        let testExpectation = expectation(description: "TestUpdateUseCaseProtocol")

        testSearchListUseCase.updateUseCaseProtocol(searchKeyword: "TestUpdateKeyword")
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { result in
                    XCTAssertEqual(result.count, 1)
                    XCTAssertEqual(result.first?.searchKeyword, "TestUpdateKeyword")
                    
                    testExpectation.fulfill()
                }
            )
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
    }
    
    func testDeleteUseCaseProtocol() {
        let testExpectation = expectation(description: "TestDeleteUseCaseProtocol")

        testSearchListUseCase.deleteUseCaseProtocol(searchKeyword: "TestDeleteKeyword")
            .sink(
                receiveCompletion: { _ in
                    testExpectation.fulfill()
                },
                receiveValue: { }
            )
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
    }

    func testDeleteAllUseCaseProtocol() {
        let testExpectation = expectation(description: "TestDeleteAllUseCaseProtocol")

        testSearchListUseCase.deleteAllUseCaseProtocol()
            .sink(
                receiveCompletion: { _ in
                    testExpectation.fulfill()
                },
                receiveValue: { }
            )
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
        
        XCTAssertTrue(testSearchListRepository.deleteAllCalled)
    }
    
    func testSelectUseCaseProtocol() {
        let testExpectation = expectation(description: "TestSelectUseCaseProtocol")
        
        testSearchListRepository.testRepositoryEntitys = [SearchListEntity(searchKeyword: "TestSearchKeyword")]

        testSearchListUseCase.selectUseCaseProtocol(searchKeyword: "TestSearchKeyword")
            .sink(
                receiveCompletion: { _ in
                },
                receiveValue: { result in
                    XCTAssertEqual(result.count, 1)
                    XCTAssertEqual(result.first?.searchKeyword, "TestSearchKeyword")
                    
                    testExpectation.fulfill()
                }
            )
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
    }
    
    func testSelectUseCaseProtocolEmpty() {
        let expectation = expectation(description: "TestSelectUseCaseProtocolValid")
        
        testSearchListUseCase.selectUseCaseProtocol(searchKeyword: " ")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                      XCTAssertEqual(result.count, 0)
                      expectation.fulfill()
                  })
            .store(in: &testCancellables)

        wait(for: [expectation], timeout: 1.5)
    }
    
    func testSelectAllUseCaseProtocol() {
        let testExpectation = expectation(description: "TestSelectAllUseCaseProtocol")
        
        testSearchListRepository.testRepositoryEntitys = [
                SearchListEntity(searchKeyword: "TestSearchKeyword1"),
                SearchListEntity(searchKeyword: "TestSearchKeyword2")
        ]

        testSearchListUseCase.selectAllUseCaseProtocol()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { result in
                    XCTAssertEqual(result.count, 2)
                    XCTAssertEqual(result[0].searchKeyword, "TestSearchKeyword1")
                    XCTAssertEqual(result[1].searchKeyword, "TestSearchKeyword2")
                    
                    testExpectation.fulfill()
                }
            )
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
    }
    
    func testSelectSearchKeywordBindValid() {
        let testExpectation = expectation(description: "TestSelectSearchKeywordBindValid")
        testSearchListRepository.testRepositoryEntitys = [SearchListEntity(searchKeyword: "TestSearchKeyword")]

        testSearchListUseCase.selectSearchKeywordBind(searchKeyword: "TestSearchKeyword")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                      XCTAssertEqual(result.count, 1)
                      XCTAssertEqual(result.first?.searchKeyword, "TestSearchKeyword")
                testExpectation.fulfill()
                  })
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
    }
    
    func testSelectSearchKeywordBindEmpty() {
        let testExpectation = expectation(description: "TestSelectSearchKeywordBindEmpty")
        
        testSearchListRepository.testRepositoryEntitys = [
            SearchListEntity(searchKeyword: "TestSearchKeyword1"),
            SearchListEntity(searchKeyword: "TestSearchKeyword2")
        ]

        testSearchListUseCase.selectSearchKeywordBind(searchKeyword: " ")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                      XCTAssertEqual(result.count, 2)
                      XCTAssertEqual(result.first?.searchKeyword, "TestSearchKeyword1")
                testExpectation.fulfill()
                  })
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
    }
}

final class TestSearchListRepository: SearchListRepositoryProtocol {
    var testRepositoryEntitys: [SearchListEntity] = []
    var insertCalled = false
    var deleteAllCalled = false

    func insertRepositoryProtocol(searchKeyword: String) -> AnyPublisher<Void, Error> {
        insertCalled = true
        
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func updateRepositoryProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error> {
        return Just([SearchListEntity(searchKeyword: searchKeyword)])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func deleteRepositoryProtocol(searchKeyword: String) -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func deleteAllRepositoryProtocol() -> AnyPublisher<Void, Error> {
        deleteAllCalled = true
        
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func selectRepositoryProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error> {
        return Just(testRepositoryEntitys)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func selectAllRepositoryProtocol() -> AnyPublisher<[SearchListEntity], Error> {
        return Just(testRepositoryEntitys)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
