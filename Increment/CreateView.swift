//
//  CreateView.swift
//  Increment
//
//  Created by Taewoo Kim on 2022/06/14.
//

import SwiftUI

struct CreateView: View {
    @StateObject var viewModel = CreateChallengeViewModel()
    
    var dropdownList: some View {
        Group{
            DropdownView(viewModel: $viewModel.exerciseDropdown)
            DropdownView(viewModel: $viewModel.startAmountDropdown)
            DropdownView(viewModel: $viewModel.increaseDropdown)
            DropdownView(viewModel: $viewModel.lengthDropdown)
        }
//        ForEach(viewModel.dropdowns.indices, id: \.self){ index in
//            DropdownView(viewModel: $viewModel.dropdowns[index])
//        }
    }
    
    
    
    var body: some View {
        ScrollView{
            VStack {
                dropdownList
                Spacer()
                Button(action: {
                    viewModel.send(action: .createChallenge)
                }) {
                    Text("Create")
                        .font(.system(size: 24, weight: .medium))
                }
            }
            .navigationTitle("Create")
                .navigationBarBackButtonHidden(true)
                .padding(.bottom, 15)
        }
    }
}
