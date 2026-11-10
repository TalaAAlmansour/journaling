import SwiftUI

struct Splashscreen: View {
    var body: some View {
        ZStack {
            Color("bakcgroundcolor")
                .ignoresSafeArea()
            
            Image("Image11")
                .resizable()
                .frame(width: 81.46, height: 106)
                .offset(y: -74)
            
        VStack {
            Text("Journali")
                    .font(AppFont.display)
            Text("Your thoughts, your story")
                    .font(AppFont.bodyM)
            }
            .foregroundStyle(Color("Textcolor"))
            .offset(y: 30)
        }
    }
}

#Preview {
    Splashscreen()
}
