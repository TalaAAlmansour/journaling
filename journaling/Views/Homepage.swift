//
//  Homepage.swift
//  journaling
//
//  Created by Tala Almansor on 01/06/1448 AH.
//
import SwiftUI

struct Homepage: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            
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
            .navigationTitle("Journal")
            
            .toolbar{
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
                        print("Plus tapped")
                    }
                    label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .searchable(text: $searchText)
              }
            }
          }
        
    


#Preview {
    Homepage()
        .preferredColorScheme(.dark)
}

