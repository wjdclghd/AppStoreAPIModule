//
//  SearchDetailViewModel.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

public final class SearchDetailViewModel: ObservableObject {
    @Published private(set) var searchDetailEntity: SearchDetailEntity?

    public init(entity: SearchDetailEntity) {
        self.searchDetailEntity = entity
    }
}
