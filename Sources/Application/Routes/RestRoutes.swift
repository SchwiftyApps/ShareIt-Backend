//
//  RestRoutes.swift
//  Application
//
//  Created by David Dunn on 11/09/2018.
//

import Foundation
import KituraContracts
import SwiftKueryORM
import SwiftKueryPostgreSQL

func initializeRestRoutes(app: App) {
    let pool = PostgreSQLConnection.createPool(host: "postgresql-database", port: 5432, options: [.databaseName("shareit"), .password(ProcessInfo.processInfo.environment["DBPASSWORD"] ?? "nil"), .userName("postgres")], poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50, timeout: 1000))
    Database.default = Database(pool)
    app.router.post("/sample", handler: postHandler)
    
    app.router.get("/sample", handler: getHandler)
    
    app.router.delete("/sample", handler: deleteHandler)
    
    app.router.get("/sample", handler: getAllHandler)
    
    app.router.delete("/sample", handler: deleteAllHandler)
    
}

//Create a temp datastore for testing
var modelStore: [String: ARModel] = [:]

func postHandler(model: ARModel, completion: @escaping (ARModel?, RequestError?) -> Void) {
    model.save(completion)
}

func getHandler(id: String, completion: @escaping (ARModel?, RequestError?) -> Void) {
    ARModel.find(id: id, completion)
}

func deleteHandler(id: String, completion: (RequestError?) -> Void) {
    guard let _ = modelStore[id] else {
        completion(.notFound)
        return
    }
    modelStore[id] = nil
    completion(nil)
}

func getAllHandler(completion: ([ARModel]?, RequestError?) -> Void) {
    let result = modelStore.map { $1 }
    completion(result, nil)
}

func deleteAllHandler(completion: (RequestError?) -> Void) {
    modelStore = [:]
    completion(nil)
}
