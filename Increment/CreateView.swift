//
//  CreateView.swift
//  Increment
//
//  Created by Taewoo Kim on 2022/06/14.
//

import SwiftUI

struct CreateView: View {
    @State private var isActive = false
    var body: some View {
        ScrollView{
            VStack {
                DropdownView()
                DropdownView()
                DropdownView()
                DropdownView()
                DropdownView()
                Spacer()
                NavigationLink(destination: RemindView(), isActive: $isActive){
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Next").font(.system(size: 24, weight: .medium))
                    }
                }
            }.navigationTitle("Create")
                .navigationBarBackButtonHidden(true)
                .padding(.bottom, 15)
        }
    }
}
