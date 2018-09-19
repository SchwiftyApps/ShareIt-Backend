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
    let pool = PostgreSQLConnection.createPool(host: "localhost", port: 5432, options: [.databaseName("shareit")], poolOptions: ConnectionPoolOptions(initialCapacity: 1, maxCapacity: 5, timeout: 10000))
    //let pool = PostgreSQLConnection.createPool(host: "postgresql-database", port: 5432, options: [.databaseName("shareit"), .password(ProcessInfo.processInfo.environment["DBPASSWORD"] ?? "nil"), .userName("postgres")], poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50, timeout: 1000))
    Database.default = Database(pool)
    let _ = try? ARModel.createTableSync()
    
    app.router.post("/sample", handler: postHandler)
    
    app.router.get("/sample", handler: getHandler)
    
    app.router.delete("/sample", handler: deleteHandler)
    
    app.router.get("/sample", handler: getAllHandler)
    
    app.router.delete("/sample", handler: deleteAllHandler)
    
}

func postHandler(model: ARModel, completion: @escaping (ARModel?, RequestError?) -> Void) {
    model.save(completion)
}

func getHandler(id: String, completion: @escaping (ARModel?, RequestError?) -> Void) {
    ARModel.find(id: id, completion)
}

func deleteHandler(id: String, completion: @escaping (RequestError?) -> Void) {
    ARModel.delete(id: id, completion)
}

func getAllHandler(completion: @escaping ([ARModel]?, RequestError?) -> Void) {
    ARModel.findAll(completion)
}

func deleteAllHandler(completion: @escaping (RequestError?) -> Void) {
    ARModel.deleteAll(completion)
}
