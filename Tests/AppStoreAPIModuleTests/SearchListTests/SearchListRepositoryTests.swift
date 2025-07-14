//
//  SearchListRepositoryTests.swift
//  CleanArchitectureiOSTests
//
//  Created by jch on 6/29/25.
//

import Foundation
import XCTest
import Combine
@testable import AppStoreAPIModule
@testable import CoreDatabase

final class SearchListRepositoryTests: XCTestCase {
    private var testCancellables: Set<AnyCancellable>!
    private var testSearchListDatabase: TestSearchListDatabase!
    private var testSearchListRepository: SearchListRepository!

    override func setUp() {
        testCancellables = []
        let testSearchListDatabase = TestSearchListDatabase()
        testSearchListRepository = SearchListRepository(RealmSwiftDBSearchListProtocol: testSearchListDatabase)
    }

    override func tearDown() {
        testCancellables = nil
        testSearchListDatabase = nil
        testSearchListRepository = nil
    }

    func testSelectDatabase() {
        let testExpectation = XCTestExpectation(description: "TestSelectDatabase")

        testSearchListRepository.selectRepositoryProtocol(searchKeyword: "TestKeyword")
            .sink(
                receiveCompletion: { _ in
                },
                receiveValue: { result in
                    XCTAssertEqual(result.count, 1)
                    XCTAssertEqual(result.first?.searchKeyword, "TestKeyword")
                    
                    testExpectation.fulfill()
                }
            )
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1)
    }

    func testSelectAllDatabase() {
        let testExpectation = XCTestExpectation(description: "TestSelectAllDatabase")

        testSearchListRepository.selectAllRepositoryProtocol()
            .sink(
                receiveCompletion: { _ in
                },
                receiveValue: { result in
                    XCTAssertEqual(result.count, 2)
                    
                    testExpectation.fulfill()
                }
            )
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1)
    }
}

final class TestSearchListDatabase: RealmSwiftDBSearchListProtocol {
    var lastInsertedEntity: SearchListEntity?
    var lastDeletedKeyword: String?
    var insertCalled = false
    var shouldFail = false
    
    func insertDatabase<T: RealmSwiftDBSearchListEntityProtocol>(searchListEntity: T) -> AnyPublisher<Void, Error> {
        insertCalled = true
        
        if let testEntity = searchListEntity as? SearchListEntity {
            lastInsertedEntity = testEntity
        }

        return shouldFail
            ? Fail(error: NSError(domain: "", code: -1))
            .eraseToAnyPublisher()
            : Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func updateDatabase<T: RealmSwiftDBSearchListProtocol>(searchListEntity: T) -> AnyPublisher<[T], Error> {
        return shouldFail
            ? Fail(error: NSError(domain: "", code: -1))
            .eraseToAnyPublisher()
            : Just([searchListEntity])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func deleteDatabase(searchKeyword: String) -> AnyPublisher<Void, Error> {
        lastDeletedKeyword = searchKeyword
        return shouldFail
            ? Fail(error: NSError(domain: "", code: -1))
            .eraseToAnyPublisher()
            : Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func deleteAllDatabase() -> AnyPublisher<Void, Error> {
        return shouldFail
            ? Fail(error: NSError(domain: "", code: -1))
            .eraseToAnyPublisher()
            : Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func selectDatabase<T: RealmSwiftDBSearchListEntityProtocol>(searchKeyword: String) -> AnyPublisher<[T], Error> {
        guard let testSearchKeyword = SearchListEntity(searchKeyword: searchKeyword) as? T else {
            return Fail(error: NSError(domain: "CastingError", code: -2))
                .eraseToAnyPublisher()
        }

        return shouldFail
            ? Fail(error: NSError(domain: "", code: -1))
            .eraseToAnyPublisher()
            : Just([testSearchKeyword]).setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func selectAllDatabase<T: RealmSwiftDBSearchListEntityProtocol>() -> AnyPublisher<[T], Error> {
        let testEntitys = [
            SearchListEntity(searchKeyword: "selectAll1"),
            SearchListEntity(searchKeyword: "selectAll2")
        ]
        
        guard let testList = testEntitys as? [T] else {
            return Fail(error: NSError(domain: "CastingError", code: -2))
                .eraseToAnyPublisher()
        }

        return shouldFail
            ? Fail(error: NSError(domain: "", code: -1))
            .eraseToAnyPublisher()
            : Just(testList).setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
