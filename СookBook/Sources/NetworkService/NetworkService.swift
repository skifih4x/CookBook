//
//  NetworkService.swift
//  ApiTest
//
//  Created by Админ on 29.11.2022.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    private init() {}

    func fetchRandomDishes(completion: @escaping(Result<[Dish],Error>) -> Void){
        request(route: .getRandomDish, method: .get, completion: completion)
    }
    
    func fetchRandomDishesIngridients(dishId: String,completion: @escaping(Result<[Ingridients],Error>) -> Void){
        request(route: .getIngridients(dishId), method: .get, completion: completion)
    }
    
    private func request<T:Decodable>(route: Rout, method: Method, completion: @escaping(Result<T,Error>) -> Void) {
        
        guard let request = createRequest(route: route, method: method) else {
            completion(.failure(AppError.unknownError))
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data =  data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Не могу пробразовать дату в строку"
                print("The response is: \(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("The error is : \(error.localizedDescription)")
                
            }
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleResponse<T:Decodable>(result: Result<Data, Error>?, completion: (Result<T,Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            if let decodedData = response.recipes {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.unknownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func createRequest(route: Rout, method: Method, params: [String: Any]? = nil) -> URLRequest? {
        let urlString = Rout.baseUrl + route.description + Rout.apiKey
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        if let params = params {
            switch method{
            case .get:
                var urlComponents = URLComponents(string: urlString)
                urlComponents?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponents?.url
            case .post:
                let bodyData = try? JSONSerialization.data(withJSONObject: params )
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
