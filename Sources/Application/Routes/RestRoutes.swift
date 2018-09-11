//
//  RestRoutes.swift
//  Application
//
//  Created by David Dunn on 11/09/2018.
//

import Foundation
import KituraContracts

func initializeRestRoutes(app: App) {
    
    app.router.post("/sample", handler: postHandler)
    
    app.router.get("/sample", handler: getHandler)
}

//Create a temp datastore for testing
var modelStore: [Int: ARModel] = [:]

func postHandler(model: ARModel, completion: (ARModel?, RequestError?) -> Void) {
    modelStore[model.id] = model
    completion(modelStore[model.id], nil)
}

func getHandler(id: Int, completion: (ARModel?, RequestError?) -> Void) {
    guard let result = modelStore[id] else {
        completion(nil, RequestError.notFound)
        return
    }
    completion(result, nil)
}
