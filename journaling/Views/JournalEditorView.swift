//
//  JournalEditorView.swift
//  journaling
//
//  Created by Tala Almansor on 06/06/1448 AH.
//

import SwiftUI

struct JournalEditorView: View {
    @ObservedObject var viewModel: JournalViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var text = ""
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                TextField("Title", text: $title)
                    .font(AppFont.headingL)
            

                Text(Date(), format: Date.FormatStyle(date: .numeric, time: .omitted))
                    .font(AppFont.captionS)
                    .foregroundStyle(Color("Entry dates"))

                TextField("Type your Journal...", text: $text, axis: .vertical)
                    .font(AppFont.bodyL)

                Spacer()
            }
            .padding(.horizontal, 22)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        viewModel.addJournal(title: title, text: text)
                        dismiss()
                    }
                    .disabled(!viewModel.canSave(title: title, text: text))
                }
            }
        }
        .presentationDragIndicator(.visible)
       
    }
}

#Preview {
    JournalEditorView(viewModel: JournalViewModel())
        .preferredColorScheme(.dark)
}
