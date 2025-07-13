//
//  SearchListRepositoryProtocol.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

public protocol SearchListRepositoryProtocol {
    func insertRepositoryProtocol(searchKeyword: String) -> AnyPublisher<Void, Error>
    func updateRepositoryProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error>
    func deleteRepositoryProtocol(searchKeyword: String) -> AnyPublisher<Void, Error>
    func deleteAllRepositoryProtocol() -> AnyPublisher<Void, Error>
    func selectRepositoryProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error>
    func selectAllRepositoryProtocol() -> AnyPublisher<[SearchListEntity], Error>
}
