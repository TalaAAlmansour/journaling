//
//  JournalViewModel.swift
//  journaling
//
//  Created by Tala Almansor on 02/06/1448 AH.
//

import SwiftUI
import Combine
enum JournalFilter: String, CaseIterable {
    case all = "All Journals"
    case bookmarks = "Bookmarks"
}
enum JournalSort: String, CaseIterable {
    case newest = "Newest Date"
    case oldest = "Oldest Date"
}
class JournalViewModel: ObservableObject{
    @Published var journals: [Journal] = []
    @Published var searchText: String = ""
    @Published var selectedFilter: JournalFilter = .all
    @Published var selectedSort: JournalSort = .newest
    
    // search, filter logic
    var filteredJournals: [Journal] {
        var result = journals
        
        // bookmark filter
        if selectedFilter == .bookmarks {
            result = result.filter { $0.isBookmarked }
        }
        // search logic
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !query.isEmpty {
            result = result.filter { journal in
                let matchTitle = journal.title.localizedCaseInsensitiveContains(query)
                let matchText = journal.text.localizedCaseInsensitiveContains(query)
                let formattedDate = journal.date.journalFormatted
                let matchDate = formattedDate.localizedCaseInsensitiveContains(query)
                
                return matchTitle || matchText || matchDate
            }
        }
        // فلتر التاريخ
        switch selectedSort {
        case .newest:
            result.sort { $0.date > $1.date }
        case .oldest:
            result.sort { $0.date < $1.date }
        }
        
        return result
    }
    //  اضافة المذكرة
    func addJournal(title: String, text: String ) {
        guard canSave(title: title, text: text) else { return }
        let journal = Journal(title: title, text: text, date: Date(), isBookmarked: false)
        journals.append(journal)
    }
    // البوك مارك
    func toggleBookmark(_ journal: Journal) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            journals[index].isBookmarked.toggle()
        }
    }
    // حفظ المذكره اذا فاضيه او لا
    func canSave(title: String, text: String) -> Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
