//
//  Date+Journal.swift
//  journaling
//
//  Created by Tala Almansor on 07/06/1448 AH.
//

import Foundation

extension Date {
    var journalFormatted: String {
        formatted(Date.FormatStyle(date: .numeric, time: .omitted))
    }
}
