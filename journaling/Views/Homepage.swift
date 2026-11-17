//
//  Homepage.swift
//  journaling
//
//  Created by Tala Almansor on 01/06/1448 AH.
//
import SwiftUI

struct Homepage: View {
    
    //تعريف المذكرة
    @StateObject private var viewModel = JournalViewModel()
    @State private var editorMode: EditorMode?
    @State private var journalToDelete: Journal?
    @State private var showDeleteAlert = false
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.journals.isEmpty {
                    
                    VStack(spacing: 18) {
                        
                        Image("Image2")
                            .resizable()
                            .frame(width: 151.39, height: 97.32)
                        
                        Text("Begin Your Journal")
                            .font(AppFont.headingM)
                            .foregroundStyle(Color("Journal titles"))
                        
                        Text("Craft your personal diary, tap the plus icon to begin")
                            .font(AppFont.bodySupporting)
                            .multilineTextAlignment(.center)
                            .frame(width: 282)
                    }
                }
                else if viewModel.filteredJournals.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchText)
                }
                else {
                    List(viewModel.filteredJournals) {
                        journal in
                        JournalCard(journal: journal){
                            viewModel.toggleBookmark(journal)
                        }
                        .onTapGesture {
                            editorMode = .edit(journal)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 8, leading: 22, bottom: 8, trailing: 22))
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                journalToDelete = journal
                                showDeleteAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Journal")
            
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    // filtter
                    Menu {
                        Picker("Filter", selection: $viewModel.selectedFilter) {
                            Label("All Journals", systemImage: "book.closed")
                                .tag(JournalFilter.all)
                            Label("Bookmarks", systemImage: "bookmark")
                                .tag(JournalFilter.bookmarks)
                        }
                        Divider()
                        
                        Picker("Sort By", selection: $viewModel.selectedSort) {
                            Label("Newest Date", systemImage: "arrow.down")
                                .tag(JournalSort.newest)
                            Label("Oldest Date", systemImage: "arrow.up")
                                .tag(JournalSort.oldest)
                        }
                    } label: {
                        Image(systemName: viewModel.selectedFilter == .bookmarks
                              ? "line.3.horizontal.decrease.circle.fill"
                              : "line.3.horizontal.decrease")
                        .foregroundStyle(viewModel.selectedFilter == .bookmarks ? Color.indigo : .primary)
                    }
                    // +
                    Button {
                        editorMode = .new
                    }
                    label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            .sheet(item: $editorMode) { mode in
                switch mode {
                case .new:
                    JournalEditorView(viewModel: viewModel)
                case .edit(let journal):
                    JournalEditorView(viewModel: viewModel, journal: journal)
                }
            }
            .alert("Delete Journal?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) {
                    journalToDelete = nil
                }
                Button("Delete", role: .destructive) {
                    if let journal = journalToDelete {
                        viewModel.deleteJournal(journal)
                    }
                    journalToDelete = nil
                }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }
        }
    }
}


#Preview {
    Homepage()
        .preferredColorScheme(.dark)
}

