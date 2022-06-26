//
//  CreateChallengeViewModel.swift
//  Increment
//
//  Created by Taewoo Kim on 2022/06/16.
//

import SwiftUI
import Combine

typealias UserId = String

final class CreateChallengeViewModel: ObservableObject{
    @Published var exerciseDropdown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    @Published var increaseDropdown = ChallengePartViewModel(type: .increase)
    @Published var lengthDropdown = ChallengePartViewModel(type: .length)
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable]=[]
    
    enum Action {
        case createChallenge
    }
    
    init(userService: UserServiceProtocol = UserService(),
         challengeService: ChallengeServiceProtocol = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action)  {
        switch action {
        case .createChallenge:
            currentUserId().flatMap { userId -> AnyPublisher<Void, Error> in
                return self.createChallenge(userId: userId)
            }.sink { completion in
                switch completion{
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("completed")
                }
            } receiveValue: { _ in
                print("success")
            }.store(in: &cancellables)
        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, Error> {
        guard let exercise = exerciseDropdown.text,
              let startAmount = startAmountDropdown.number,
              let increase = increaseDropdown.number,
              let length = lengthDropdown.number else {
            return Fail(error: NSError()).eraseToAnyPublisher()
        }
        
        let challenge = Challenge(
            exercise: exercise,
            startAmount: startAmount,
            increase: increase,
            length: length,
            userId: userId,
            startDate: Date()
        )
        
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    private func currentUserId() -> AnyPublisher<UserId, Error> {
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId, Error> in
            if let userId = user?.uid {
                return Just(userId)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }else{
                return self.userService
                    .signInAnonymously()
                    .map{$0.uid}
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

extension CreateChallengeViewModel {
    struct ChallengePartViewModel: DropdownItemProtocol {
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
        }
        
        var isSelected: Bool = false
        private let type: ChallengePartType
        
        init(type: ChallengePartType) {
            switch type{
            case .exercise:
                self.options = ExerciseOption.allCases.map{$0.toDropdownOption}
            case .startAmount:
                self.options = StartOption.allCases.map{$0.toDropdownOption}
            case .increase:
                self.options = IncreaseOption.allCases.map{$0.toDropdownOption}
            case .length:
                self.options = LegthOption.allCases.map{$0.toDropdownOption}
            }
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        enum ExerciseOption:String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue), formatted: rawValue.capitalized)
            }
        }
        
        enum StartOption:Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue)")
            }
        }
        
        enum IncreaseOption:Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "+\(rawValue)")
            }
        }
        
        enum LegthOption:Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue) days")
            }
        }
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}
