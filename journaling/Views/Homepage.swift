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
    @State private var isPresentingEditor = false
    
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
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 8, leading: 22, bottom: 8, trailing: 22))
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
                        Button("Sort by Bookmark") {
                            print("Bookmark")
                        }
                        Button("Sort by Entry Date") {
                            print("Date")
                        }
                    }
                    label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                    // +
                    Button {
                        isPresentingEditor = true
                    }
                    label: {
                        Image(systemName: "plus")
                    }
                }
            }
            //.searchable(text: $searchText)
            .searchable(text: $viewModel.searchText)
            .sheet(isPresented: $isPresentingEditor)
            {
                JournalEditorView(viewModel: viewModel)
            }
        }
    }
}


#Preview {
    Homepage()
        .preferredColorScheme(.dark)
}

