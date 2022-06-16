//
//  CreateView.swift
//  Increment
//
//  Created by Taewoo Kim on 2022/06/14.
//

import SwiftUI

struct CreateView: View {
    @StateObject var viewModel = CreateChallengeViewModel()
    @State private var isActive = false
    
    var dropdownList: some View {
        ForEach(viewModel.dropdowns.indices, id: \.self){ index in
            DropdownView(viewModel: $viewModel.dropdowns[index])
        }
    }
    
    var body: some View {
        ScrollView{
            VStack {
                dropdownList
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
