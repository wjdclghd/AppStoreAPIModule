//
//  SearchListView.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import SwiftUI

public struct SearchListView: View {
    @StateObject private var viewModel: SearchListViewModel
    private let onPush: (String) -> Void

    public init(viewModel: @autoclosure @escaping () -> SearchListViewModel, onPush: @escaping (String) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel())
        self.onPush = onPush
    }

    public var body: some View {
        VStack(spacing: 0) {
            TextField("검색어를 입력하세요", text: $viewModel.searchKeyword)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onSubmit {
                    let searchKeyword = viewModel.searchKeyword.trimmingCharacters(in: .whitespaces)
                    guard !searchKeyword.isEmpty else {
                        return
                    }

                    viewModel.searchKeywordSave(searchKeyword: searchKeyword)
                    
                    onPush(searchKeyword)
                }
            
            ZStack {
                if viewModel.isLoading {
                    ProgressView("로딩 중...")
                } else if viewModel.searchEntitys.isEmpty {
                    Text("검색 결과가 없습니다.")
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.searchEntitys, id: \.searchKeyword) { entity in
                        Button {
                            onPush(entity.searchKeyword)
                        } label: {
                            Text(entity.searchKeyword)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
        }
        .navigationTitle("검색 기록")
    }
}
