//
//  NetworkManager.swift
//  Art App
//
//  Created by user on 27.01.2025.
//
import UIKit
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetchAF(completion: @escaping (Result<[Artist], AFError>) -> Void) {
        let URLString = "https://cdn.accelonline.io/OUR6G_IgJkCvBg5qurB2Ag/files/YPHn3cnKEk2NutI6fHK04Q.json"
        
        guard let url = URL(string: URLString) else {return}
        
        let decoder = JSONDecoder()
        
        AF.request(url)
            .validate()
            .responseDecodable(of: ArtModel.self, decoder: decoder) { response in
                switch response .result {
                case .success(let modelResponse):
                    print("Success: \(modelResponse)")
                    completion(.success(modelResponse.artists))
                case .failure(let error):
                    print("Error \(error)")
                    completion(.failure(error))
                }
            }
    }
}
