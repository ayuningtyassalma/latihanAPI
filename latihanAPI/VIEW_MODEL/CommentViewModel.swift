//
//  CommentViewModel.swift
//  latihanAPI
//
//  Created by Phincon on 14/03/23.
//

import Foundation

protocol CommentViewProtocol {
    var urlString : String { get set }
    var bindCommentData : (([Comment]?) -> ())? {get set}
    func fetchDataComment()
}

class CommentViewModel: CommentViewProtocol {
    private var apiService : ApiServiceProtocol?
    var urlString: String
    var data : [Comment]?
    
    var bindCommentData: (([Comment]?) -> ())?
    
    init(urlString : String, apiService : ApiServiceProtocol) {
        self.urlString = urlString
        // urlString di passing ke sini biar dipanggil
//        self.apiService = APIServiceComment(url: self.urlString)
        self.apiService = apiService
        if let url = URL(string: urlString){
            self.apiService?.get(url: url)
        }
     
        
    
        fetchDataComment()
    }
    func fetchDataComment() {
//        self.apiService?.callApi(completion: { listComment in
//            if let modelComment = listComment {
//                self.data = modelComment
//                self.bindCommentData?(modelComment)
//            } else{
//                self.bindCommentData?(nil)
//            }
//        })
        self.apiService?.callApi(model: [Comment].self, completion: { response in
            switch response{
            case .success(let success):
//                self.bindCommentData
                self.bindCommentData?(success)
            case .failure(let fail):
                self.bindCommentData?(nil)
            }
        })
        
    }
        
    func numberOfRowInSection() -> Int{
        return self.data?.count ?? 0
    }
    
    
}
