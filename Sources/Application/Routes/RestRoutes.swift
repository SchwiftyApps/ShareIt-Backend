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
    
    app.router.get("/sample", handler: getAllHandler)
    
    app.router.delete("/sample", handler: deleteAllHandler)
    
}

//Create a temp datastore for testing
var modelStore: [String: ARModel] = [:]

func postHandler(model: ARModel, completion: (ARModel?, RequestError?) -> Void) {
    modelStore[model.id] = model
    completion(modelStore[model.id], nil)
}

func getHandler(id: String, completion: (ARModel?, RequestError?) -> Void) {
    guard let result = modelStore[id] else {
        completion(nil, RequestError.notFound)
        return
    }
    completion(result, nil)
}

func getAllHandler(completion: ([ARModel]?, RequestError?) -> Void) {
    let result = modelStore.map { $1 }
    completion(result, nil)
}

func deleteAllHandler(completion: (RequestError?) -> Void) {
    modelStore = [:]
    completion(nil)
}
