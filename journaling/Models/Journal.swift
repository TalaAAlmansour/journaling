//
//  Journal.swift
//  journaling
//
//  Created by Tala Almansor on 02/06/1448 AH.
//

import Foundation

struct Journal: Identifiable {
    let id = UUID()
    var title: String
    var text: String
    var date: Date
    var isBookmarked: Bool
}
