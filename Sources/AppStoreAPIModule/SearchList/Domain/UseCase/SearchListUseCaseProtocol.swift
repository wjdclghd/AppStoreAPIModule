//
//  SearchListUseCaseProtocol.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

public protocol SearchListUseCaseProtocol {
    func insertUseCaseProtocol(searchKeyword: String) -> AnyPublisher<Void, Error>
    func updateUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error>
    func deleteUseCaseProtocol(searchKeyword: String) -> AnyPublisher<Void, Error>
    func deleteAllUseCaseProtocol() -> AnyPublisher<Void, Error>
    func selectUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error>
    func selectAllUseCaseProtocol() -> AnyPublisher<[SearchListEntity], Error>
    func selectSearchKeywordBind(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error>
}
