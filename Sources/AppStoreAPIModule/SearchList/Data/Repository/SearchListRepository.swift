//
//  SearchListRepository.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine
import CoreDatabase

public final class SearchListRepository: SearchListRepositoryProtocol {
    
    private let realmSwiftDBSearchListProtocol: RealmSwiftDBSearchListProtocol

    public init(realmSwiftDBSearchListProtocol: RealmSwiftDBSearchListProtocol) {
        self.realmSwiftDBSearchListProtocol = realmSwiftDBSearchListProtocol
    }

    public func insertRepositoryProtocol(searchKeyword: String) -> AnyPublisher<Void, Error> {
        guard !searchKeyword.trimmingCharacters(in: .whitespaces).isEmpty else {
            return Fail(error: SearchListRepositoryError.invalidQuery).eraseToAnyPublisher()
        }
        
        let searchListEntity = SearchListEntity(searchKeyword: searchKeyword)
        
        return realmSwiftDBSearchListProtocol.insertDatabase(searchListEntity: searchListEntity)
            .mapError{SearchListRepositoryError.databaseError($0)}
            .eraseToAnyPublisher()
    }

    public func updateRepositoryProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error> {
        guard !searchKeyword.trimmingCharacters(in: .whitespaces).isEmpty else {
            return Fail(error: SearchListRepositoryError.invalidQuery).eraseToAnyPublisher()
        }
        
        let searchListEntity = SearchListEntity(searchKeyword: searchKeyword)
        
        return realmSwiftDBSearchListProtocol.updateDatabase(searchListEntity: searchListEntity)
            .mapError{SearchListRepositoryError.databaseError($0)}
            .eraseToAnyPublisher()
    }

    public func deleteRepositoryProtocol(searchKeyword: String) -> AnyPublisher<Void, Error> {
        guard !searchKeyword.trimmingCharacters(in: .whitespaces).isEmpty else {
            return Fail(error: SearchListRepositoryError.invalidQuery).eraseToAnyPublisher()
        }
        
        return realmSwiftDBSearchListProtocol.deleteDatabase(searchKeyword: searchKeyword)
            .mapError{SearchListRepositoryError.databaseError($0)}
            .eraseToAnyPublisher()
    }

    public func deleteAllRepositoryProtocol() -> AnyPublisher<Void, Error> {
        return realmSwiftDBSearchListProtocol.deleteAllDatabase()
            .mapError{SearchListRepositoryError.databaseError($0)}
            .eraseToAnyPublisher()
    }

    public func selectRepositoryProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error> {
        guard !searchKeyword.trimmingCharacters(in: .whitespaces).isEmpty else {
            return Fail(error: SearchListRepositoryError.invalidQuery).eraseToAnyPublisher()
        }
        
        return realmSwiftDBSearchListProtocol.selectDatabase(searchKeyword: searchKeyword)
            .mapError{SearchListRepositoryError.databaseError($0)}
            .eraseToAnyPublisher()
    }

    public func selectAllRepositoryProtocol() -> AnyPublisher<[SearchListEntity], Error> {
        return realmSwiftDBSearchListProtocol.selectAllDatabase()
            .mapError{SearchListRepositoryError.databaseError($0)}
            .eraseToAnyPublisher()
    }
}
