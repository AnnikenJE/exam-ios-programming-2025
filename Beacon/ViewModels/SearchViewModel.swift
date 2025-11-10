//
//  SearchViewModel.swift
//  Beacon
//
// Kandidatnr 97

// ViewModel for search in ExploreView and children.
// Source: Combine. (2024). Tanaschita.com. https://tanaschita.com/combine-swiftui-search-query-debounce/
// - Based on code from website.

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    private var searchTextCancellable = Set<AnyCancellable>()
    
//    init() {
//        $searchText
//            .debounce(for: .milliseconds(2000), scheduler: RunLoop.main) // 500 instead of 300 because me personally felt it did too many API calls.
//            .sink{ [weak self] searchInput in
//                Task {
//                    self?.updateSearch(userSearchInput: searchText)
//                }
//                print("SearchInoutTest: ", searchInput)
//            }
//            .store(in: &searchTextCancellable)
//    }
//    func updateSearch(userSearchInput: String?){
//        searchText = userSearchInput ?? ""
//    }
}
