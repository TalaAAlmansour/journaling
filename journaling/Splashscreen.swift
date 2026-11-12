import SwiftUI

struct Splashscreen: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            Homepage()
        }
        else {
            VStack {
                
                Image("Image11")
                    .resizable()
                    .frame(width: 81.46, height: 106)
                
                Text("Journali")
                    .font(AppFont.display)
                Text("Your thoughts, your story")
                    .font(AppFont.bodyM)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
        }
    }
}


#Preview {
    Splashscreen()
    .preferredColorScheme(.dark)
}
