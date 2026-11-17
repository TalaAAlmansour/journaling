//
//  EditorMode.swift
//  journaling
//
//  Created by Tala Almansor on 07/06/1448 AH.
//

import Foundation
enum EditorMode: Identifiable {
    case new
    case edit(Journal)

    var id: String {
        switch self {
        case .new:
            return "new"
        case .edit(let journal):
            return journal.id.uuidString
        }
    }
}
