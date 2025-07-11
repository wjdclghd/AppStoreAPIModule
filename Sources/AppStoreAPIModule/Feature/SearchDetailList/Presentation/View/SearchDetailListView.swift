//
//  SearchDetailListView.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import SwiftUI

public struct SearchDetailListView: View {
    @StateObject public var viewModel: SearchDetailListViewModel
    private let onPush: (SearchDetailEntity) -> Void
    
    public init(viewModel: @autoclosure @escaping () -> SearchDetailListViewModel, onPush: @escaping (SearchDetailEntity) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel())
        self.onPush = onPush
    }
    
    public var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("검색 중...")
                    .padding()
            }
            
            if viewModel.searchDetailResults.isEmpty && !viewModel.isLoading {
                Text("검색 결과가 없습니다.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(viewModel.searchDetailResults, id: \.id) { entity in
                    Button {
                        onPush(entity)
                    } label: {
                        HStack(alignment: .top, spacing: 12) {
                            if let urlString = entity.artworkUrl100,
                               let url = URL(string: urlString) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 60, height: 60)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(12)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(entity.trackName ?? "앱 이름 없음")
                                    .font(.headline)
                                Text(entity.artistName ?? "개발사 정보 없음")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                if let rating = entity.averageUserRating {
                                    Text("평점: \(rating, specifier: "%.1f")")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("검색 결과")
    }
}
