//
//  ChallengeService.swift
//  Increment
//
//  Created by Taewoo Kim on 2022/06/26.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChallengeServiceProtocol {
    func create(_ challenge: Challenge) -> AnyPublisher<Void, IncrementError>
}

final class ChallengeService: ChallengeServiceProtocol{
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, IncrementError> {
        return Future<Void, IncrementError> { promise in
            do{
                _ = try self.db.collection("challenges").addDocument(from: challenge) { error in
                    if let error = error{
                        promise(.failure(.default(description: error.localizedDescription)))
                    }else{
                        promise(.success(()))
                    }
                }
            }catch{
                promise(.failure(.default()))
            }
        }.eraseToAnyPublisher()
    }
}
