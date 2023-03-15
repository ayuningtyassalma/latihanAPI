//
//  ApiService.swift
//  latihanAPI
//
//  Created by Phincon on 14/03/23.
//

import Foundation

protocol APIServiceCommentProtocol {
    var url : String {get}
    func callApi(completion: @escaping ([Comment]?) -> Void)
}

protocol ApiServiceProtocol {
    mutating func get(url: URL)
    func callApi<T:Codable>(model:T.Type, completion:@escaping (Result<T, Error>)->Void)
    
}

struct ApiService: ApiServiceProtocol  {
    private var url = URL(string: "")
    mutating func get(url: URL) {
        self.url = url
    }
    
    func callApi<T>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        guard let url = self.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                do {
                    let modelData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(modelData))
                } catch let error {
                    completion(.failure(error))
                    
                }
            }
        }.resume()
    }
    
    
}
struct APIServiceComment : APIServiceCommentProtocol {
    var url: String
    
//    di init biar manggil URL dan si APIService nya bisa ngejalanin si URL
    init(url : String) {
        self.url = url
    }
    
    func callApi(completion: @escaping ([Comment]?) -> Void) {
        let commentURL = URLBuilder.shared.createUrl(required: self.url)
        
        URLSession.shared.dataTask(with: commentURL) { data, responseStatus, error in
            if let success = data{
                do{
                    // biar nyesuain model yg dibikin sama JSON response nya
//                    let decoder = JSONDecoder()
                    let commentData = try JSONDecoder().decode([Comment].self, from: success)
                    completion(commentData)
                } catch{
                    completion(nil)
                }
            }else if let error = error {
                print("error nich", error)
            }
        }.resume()
    }
    
    
}

struct URLBuilder {
    static let shared = URLBuilder()
    private init() {}
    func createUrl(required url: String) -> URL {
        if let url = URL(string: url) {
            return url
        }
        return URL(string: "")!
    }
}

