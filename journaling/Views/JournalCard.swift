//
//  JournalCard.swift
//  journaling
//
//  Created by Tala Almansor on 05/06/1448 AH.
//

import SwiftUI

struct JournalCard: View {
    let journal: Journal
    let onBookmarkTap: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 7){
            HStack {
                Text(journal.title)
                    .font(AppFont.titlecard)
                    .foregroundStyle(Color("Journal titles"))
                Spacer()
                Button {
                    onBookmarkTap()
                } label: {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 24))
                        .foregroundStyle(Color("Savebutton"))
                }
                        .buttonStyle(.borderless)
            }
            Text(journal.date, format: Date.FormatStyle(date: .numeric, time: .omitted))
                .font(AppFont.captionS)
                .foregroundStyle(Color("Entry dates"))
                 
                 Text(journal.text)
                .font(AppFont.bodyM)
                .lineLimit(5)
                .padding(.top, 16)
                 
                 }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("Journalcards"), in: RoundedRectangle(cornerRadius: 30))
    }
}


#Preview {
    JournalCard(journal: Journal(title: "Birthday", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio.", date: Date(), isBookmarked: false)) {}
        .preferredColorScheme(.dark)
}
