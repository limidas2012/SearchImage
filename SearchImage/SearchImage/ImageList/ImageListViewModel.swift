//
//  ImageListViewModel.swift
//  SearchImage
//
//  Created by Limi Das on 11/09/22.
//  Copyright © 2022 Limi Das. All rights reserved.
//

import Foundation
class ImageListViewModel{
    
    var showSpinner:((Bool) -> ())? = nil
    var showTableView:((Bool) -> ())? = nil
    var reloadTableView:(() -> ())? = nil
    var localDBFetcher:LocalDataFetchable? = nil
    var NetworkHandler:NetworkClient? = nil
    var images:[ImageModel] = []
    
    
    func initiate(){
        self.localDBFetcher = FMDBHandler()
        self.NetworkHandler = NetworkClient()
    }
    
    func isDataAvailable()-> Bool {
        
        return true
    }
    
    func fetchImageDataFromDB() -> [ImageModel]{
        
        return self.localDBFetcher?.fetchImageList() ?? []
        
    }
    
//    func fetchImageDataFromServer(_ response: @escaping (_ models: [ImageModel]) -> Void) {
    func fetchImageDataFromServer() {
        self.showSpinner?(true)
        self.showTableView?(false)
        self.NetworkHandler?.requestAPIInfo(completionHandler: { result in
            self.showSpinner?(false)
            
            switch result{
            case .success(let value):
                //print(value)
               // let imageModels = value.value!
                let imageModels = value.value?.compactMap({ val -> ImageModel? in
                    guard let idStr = val.id,let id = Int(idStr),
                    let name = val.provider?.name,
                    let imageURL = val.image?.url,
                    let thumbURL = val.image?.url
                    else
                    {
                       return nil
                    }
                        
                    let model = ImageModel.init(ID: id, name: name, imageURL: imageURL, thumbURL: thumbURL)
                    return model
                })
                self.images = imageModels ?? []
//                print("value before tablevw")
//                print(self.images)
//                print(imageModels)
                //print(value)
                self.showTableView?(true)
                self.reloadTableView?()
                
            case .failure(_):
                self.images = []
                self.reloadTableView?()
                self.showTableView?(false)
                
            }
       // }
        
    })
    
  }
}

protocol LocalDataFetchable{
    
    func fetchImageList() -> [ImageModel]
    func insert(images:[ImageModel])
    
}


