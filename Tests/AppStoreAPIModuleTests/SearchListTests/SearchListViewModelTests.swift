//
//  SearchListViewModelTests.swift
//  CleanArchitectureiOSTests
//
//  Created by jch on 6/29/25.
//

import Foundation
import XCTest
import Combine
import SwiftUI
@testable import iOSCleanArchitecture

final class SearchListViewModelTests: XCTestCase {
    private var testCancellables: Set<AnyCancellable>!
    private var testSearchListUseCase: TestSearchListUseCase!
    private var testSearchListViewModel: SearchListViewModel!

    override func setUpWithError() throws {
        testCancellables = []
        testSearchListUseCase = TestSearchListUseCase()
        testSearchListUseCase.testSkipSelectAll = true
        testSearchListViewModel = SearchListViewModel(useCase: testSearchListUseCase)
    }

    override func tearDownWithError() throws {
        testCancellables = nil
        testSearchListUseCase = nil
        testSearchListViewModel = nil
    }
    
    func testSearchKeywordBind() {
        let testExpectation = expectation(description: "TestSearchKeywordBind")
        
        testSearchListUseCase.testUseCaseEntitys = [
                SearchListEntity(searchKeyword: "TestSearchKeyword")
        ]
        
        testSearchListViewModel.$searchEntitys
            .drop(while: { $0.isEmpty })
            .sink { entitys in
                XCTAssertEqual(entitys.count, 1)
                XCTAssertEqual(entitys.first?.searchKeyword, "TestSearchKeyword")
                testExpectation.fulfill()
            }
            .store(in: &testCancellables)

        testSearchListViewModel.searchKeyword = "TestSearchKeyword"

        wait(for: [testExpectation], timeout: 1.5)
    }
    
    func testSearchKeywordSave() {
        let testExpectation = expectation(description: "TestSearchKeywordSave")
        let testSearchKeyword = "TestSearchKeyword"

        testSearchListUseCase.testInsertCalled = false
        testSearchListUseCase.testInserteSearchKeyword = nil
        testSearchListUseCase.testInsertExpectation = testExpectation

        testSearchListViewModel.searchKeywordSave(searchKeyword: testSearchKeyword)

        wait(for: [testExpectation], timeout: 1.5)

        XCTAssertTrue(testSearchListUseCase.testInsertCalled)
        XCTAssertEqual(testSearchListUseCase.testInserteSearchKeyword, testSearchKeyword)
    }
    
    func testInitSearchKeywordAllList() {
        let testExpectation = expectation(description: "TestInitSearchKeywordAllList")
        
        testSearchListUseCase.testSkipSelectAll = false
        
        testSearchListUseCase.testUseCaseEntitys = [
                SearchListEntity(searchKeyword: "TestSearchKeyword1"),
                SearchListEntity(searchKeyword: "TestSearchKeyword2")
        ]
        
        testSearchListViewModel = SearchListViewModel(useCase: testSearchListUseCase)

        testSearchListViewModel.$searchEntitys
            .dropFirst()
            .sink { entitys in
                XCTAssertEqual(entitys.count, 2)
                XCTAssertEqual(entitys[0].searchKeyword, "TestSearchKeyword1")
                XCTAssertEqual(entitys[1].searchKeyword, "TestSearchKeyword2")
                testExpectation.fulfill()
            }
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
    }
    
    func testInitSearchKeywordAllListFail() {
        let testExpectation = expectation(description: "TestInitSearchKeywordAllListFail")
        
        testSearchListUseCase.testFailSelectAll = true
        testSearchListViewModel = SearchListViewModel(useCase: testSearchListUseCase)

        testSearchListViewModel.$errorMessage
            .drop(while: { $0 == nil })
            .sink { error in
                XCTAssertEqual(error, "SelectAll Error")
                testExpectation.fulfill()
            }
            .store(in: &testCancellables)

        wait(for: [testExpectation], timeout: 1.5)
    }
    
    func testSearchKeywordBindFail() {
        let testExpectation = expectation(description: "TestSearchKeywordBindFail")
        testSearchListUseCase.testFailBind = true

        testSearchListViewModel.$errorMessage
            .drop(while: { $0 == nil })
            .sink { error in
                XCTAssertEqual(error, "Bind Error")
                testExpectation.fulfill()
            }
            .store(in: &testCancellables)

        testSearchListViewModel.searchKeyword = "TestSearchKeyword"

        wait(for: [testExpectation], timeout: 1.5)
    }
    
    func testSearchKeywordInsertFail() {
        let testExpectation = expectation(description: "TestSearchKeywordInsertFail")
        testSearchListUseCase.testFailInsert = true

        testSearchListViewModel.$errorMessage
            .drop(while: { $0 == nil })
            .sink { error in
                XCTAssertNotNil(error)
                XCTAssertEqual(error, "Insert Error")
                testExpectation.fulfill()
            }
            .store(in: &testCancellables)
        
        testSearchListViewModel.searchKeywordSave(searchKeyword: "TestInsertFailSearchKeyword")

        wait(for: [testExpectation], timeout: 1.5)
    }
    
    func testSearchKeywordSelectFail() {
        let testExpectation = expectation(description: "TestSearchKeywordSelectFail")
        testSearchListUseCase.testFailSelect = true

        testSearchListViewModel.$errorMessage
            .drop(while: { $0 == nil })
            .sink { error in
                XCTAssertEqual(error, "Select Error")
                testExpectation.fulfill()
            }
            .store(in: &testCancellables)

        testSearchListViewModel.searchKeywordList(searchKeyword: "TestSearchKeyword")

        wait(for: [testExpectation], timeout: 1.5)
    }
}

final class TestSearchListUseCase: SearchListUseCaseProtocol {
    var testSkipSelectAll = false
    var testFailSelectAll = false
    var testFailInsert = false
    var testFailSelect = false
    var testFailBind = false
    var testInsertCalled = false
    var testInserteSearchKeyword: String?
    var testInsertExpectation: XCTestExpectation?
    var testUseCaseEntitys: [SearchListEntity] = []
    
    func insertUseCaseProtocol(searchKeyword: String) -> AnyPublisher<Void, Error> {
        testInsertCalled = true
        testInserteSearchKeyword = searchKeyword
        testInsertExpectation?.fulfill()
        
        if testFailInsert {
            return Fail(error: NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "Insert Error"]))
                .eraseToAnyPublisher()
        }
        
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func updateUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error> {
        return Just([SearchListEntity(searchKeyword: searchKeyword)])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func deleteUseCaseProtocol(searchKeyword: String) -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func deleteAllUseCaseProtocol() -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func selectUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error> {
        if testFailSelect {
            return Fail(error: NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "Select Error"]))
                .eraseToAnyPublisher()
        }
        
        return Just(testUseCaseEntitys)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func selectAllUseCaseProtocol() -> AnyPublisher<[SearchListEntity], Error> {
        if testFailSelectAll {
            return Fail(error: NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "SelectAll Error"]))
                .eraseToAnyPublisher()
        }
        
        if testSkipSelectAll {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return Just(testUseCaseEntitys)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    
    func selectSearchKeywordBind(searchKeyword: String) -> AnyPublisher<[iOSCleanArchitecture.SearchListEntity], any Error> {
        if testFailBind {
            return Fail(error: NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "Bind Error"]))
                .eraseToAnyPublisher()
        }
        
        return Just(testUseCaseEntitys)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
