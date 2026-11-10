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
        }
    }
}

#Preview {
    Splashscreen()
}
