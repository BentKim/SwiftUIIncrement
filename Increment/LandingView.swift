//
//  ContentView.swift
//  Increment
//
//  Created by Taewoo Kim on 2022/06/13.
//

import SwiftUI

struct LandingView: View {
    @State private var isActive = false
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack{
                    Spacer().frame(height: proxy.size.height * 0.18)
                    Text("Increment")
                        .font(.system(size: 64, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: CreateView(), isActive: $isActive){
                        Button(action: {
                            isActive = true
                        }) {
                            HStack(spacing: 15){
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Text("Create a chellenge")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }.padding(15)
                            .buttonStyle(PrimaryButtonStyle())
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Image("pullups")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(.black.opacity(0.4))
                        .frame(width: proxy.size.width)
                        .edgesIgnoringSafeArea(.all)
                    )
            }
        }.accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().previewDevice("iPhone 8")
        LandingView().previewDevice("iPhone 11 Pro")
        LandingView().previewDevice("iPhone 11 Pro Max")
    }
}
