//
//  SearchListRepositoryError.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation

public enum SearchListRepositoryError: LocalizedError {
    case invalidQuery
    case databaseError(Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidQuery:
            return "검색어가 비어 있습니다. 유효한 검색어를 입력해주세요."
        case .databaseError(let error):
            return "데이터베이스 오류가 발생했습니다: \(error.localizedDescription)"
        }
    }
}
