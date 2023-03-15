//
//  ImageViewModel.swift
//  latihanAPI
//
//  Created by Salma Ayu on 15/03/23.
//

import Foundation

protocol ImageViewProtocol {
    var urlString : String {get set}
    var bindImageData : (([ImageApi]?) -> ())? {get set}
    func fetchDataImage()
}

class ImageViewModel: ImageViewProtocol {
    
    private var apiService : ApiServiceProtocol?
    var urlString: String
    var data : [ImageApi]?
    
    var bindImageData: (([ImageApi]?) -> ())?
    
    init(urlString: String, apiService : ApiServiceProtocol) {
        self.urlString = urlString
        self.apiService = apiService
        
        
        if let url = URL(string: urlString){
            self.apiService?.get(url: url)
            
        }
        
        fetchDataImage()
    }
    
    func fetchDataImage() {
        self.apiService?.callApi(model: [ImageApi].self, completion: { response in
            switch response{
            case .success(let success):
                self.bindImageData?(success)
            case .failure(let fail):
                self.bindImageData?(nil)
            }
        })
        
    }
    
    
    func numberOfRowInSection() -> Int{
        return self.data?.count ?? 0
    }
}
