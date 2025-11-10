//
//  SearchViewModel.swift
//  Beacon
//
// Kandidatnr 97

// ViewModel for search in ExploreView.
// Source: Combine. (2024). Tanaschita.com. https://tanaschita.com/combine-swiftui-search-query-debounce/
// Source: Saidi, D. (2025). Creating a debounced search context for performant SwiftUI searches. Danielsaidi.com. https://danielsaidi.com/blog/2025/01/08/creating-a-debounced-search-context-for-performant-swiftui-searches

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var debouncedText = ""
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates() // Only assigns if it is changes, and makes sure its diffrent from the previous one
            .assign(to: &$debouncedText) // Assigning it to new variable to save the delayed text
}
