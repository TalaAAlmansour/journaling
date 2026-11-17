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
    @State private var showDiscardDialog = false
    private var hasChanges: Bool {
        viewModel.canSave(title: title, text: text)
    }
    enum Field {
        case title, body
    }
    @FocusState private var focusedField: Field?
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Title", text: $title)
                            .font(AppFont.headingL)
                            .focused($focusedField, equals: .title)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .body
                            }
                        
                        Text(Date().journalFormatted)
                            .font(AppFont.captionS)
                            .foregroundStyle(Color("Entry dates"))
                        
                        TextField("Type your Journal...", text: $text, axis: .vertical)
                            .font(AppFont.bodyL)
                            .focused($focusedField, equals: .body)
                        Color.clear
                           .frame(height: 1)
                            .id("bottomID")
                    }
                    .padding(.horizontal, 22)
                }
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: text) {
                        withAnimation(.easeOut(duration: 0.15)) {
                            proxy.scrollTo("bottomID", anchor: .bottom)
                        }
                }
            }
            .onAppear {
                focusedField = .title
            }
            
            .toolbar {
                // الاكس يسار
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .close) {
                        if hasChanges {
                            showDiscardDialog = true
                        }
                        else {
                            dismiss()
                        }
                    }
                    .confirmationDialog("Discard Changes", isPresented: $showDiscardDialog, titleVisibility: .hidden) {
                        Button("Discard Changes", role: .destructive) {
                            dismiss()
                        }
                        Button("Keep Editing") { }
                    } message: {
                        Text("Are you sure you want to discard changes on this journal?")
                    }
                }
                // الصح يمين
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
        .interactiveDismissDisabled(hasChanges)
    }
}

#Preview {
    JournalEditorView(viewModel: JournalViewModel())
        .preferredColorScheme(.dark)
}
