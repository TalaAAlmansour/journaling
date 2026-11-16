//
//  JournalViewModel.swift
//  journaling
//
//  Created by Tala Almansor on 02/06/1448 AH.
//

import SwiftUI
import Combine

class JournalViewModel: ObservableObject{
    @Published var journals: [Journal] = []
    @Published var searchText: String = ""
   // search logic
    var filteredJournals: [Journal] {
            let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !query.isEmpty else { return journals }
            
            return journals.filter { journal in
                let matchTitle = journal.title.localizedCaseInsensitiveContains(query)
                let matchText = journal.text.localizedCaseInsensitiveContains(query)
                let formattedDate = journal.date.formatted(Date.FormatStyle(date: .numeric, time: .omitted))
                let matchDate = formattedDate.localizedCaseInsensitiveContains(query)
                
                return matchTitle || matchText || matchDate
            }
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

