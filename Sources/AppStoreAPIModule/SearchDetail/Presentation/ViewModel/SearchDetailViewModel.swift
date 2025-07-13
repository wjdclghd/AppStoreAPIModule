//
//  SearchDetailViewModel.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation

public final class SearchDetailViewModel: ObservableObject {
    @Published var searchDetailEntity: SearchDetailEntity?

    public init(entity: SearchDetailEntity) {
        self.searchDetailEntity = entity
    }
}
