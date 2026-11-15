//
//  JournalCard.swift
//  journaling
//
//  Created by Tala Almansor on 05/06/1448 AH.
//

import SwiftUI

struct JournalCard: View {
    let journal: Journal
    var body: some View {
        VStack(alignment: .leading, spacing: 7){
            HStack {
                Text(journal.title)
                    .font(AppFont.titlecard)
                    .foregroundStyle(Color("Journal titles"))
                Spacer()
                Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 24))
            }
            Text("02/09/2024")
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
    JournalCard(journal: Journal(title: "My Birthday", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio.", date: Date(), isBookmarked: true))
        .preferredColorScheme(.dark)
}
