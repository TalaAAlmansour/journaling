//
//  JournalViewModel.swift
//  journaling
//
//  Created by Tala Almansor on 02/06/1448 AH.
//

import SwiftUI
import Combine

class JournalViewModel: ObservableObject{
    @Published var Journals: [Journal] = []
    
    // دالة اضافة المذكرة
    func addJournal(title: String, text: String ) {
        let Journal = Journal(title: title, text: text, date: Date(), isBookmarked: false)
        Journals.append(Journal)
    }
}

