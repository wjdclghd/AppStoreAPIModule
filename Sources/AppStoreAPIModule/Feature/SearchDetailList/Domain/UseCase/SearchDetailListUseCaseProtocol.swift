//
//  SearchDetailListUseCaseProtocol.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

protocol SearchDetailListUseCaseProtocol{
    func searchDetailListUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchDetailEntity], Error>
}
