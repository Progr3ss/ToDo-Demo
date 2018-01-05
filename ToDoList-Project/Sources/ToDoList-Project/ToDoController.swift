//
//  ToDoController.swift
//  ToDoList-Project
//
//  Created by Martin Chibwe on 1/3/18.
//

import Foundation
import Kitura
import LoggerAPI
import HeliumLogger
import SwiftyJSON



class AllRemoteOriginMiddleware: RouterMiddleware {
    //Anything that comes in will be able to talk to the handle
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        response.headers["Access-Control-Allow-Origin"] = "*"
        next()
    }
}

class TodoController
{
    
    
    
    let router = Router()
    var list = TodoList()
    
    func collectJSONBody(request: RouterRequest) -> JSON {
        guard let body = request.body else {
            Log.error("No body in request")
            return nil
            
        }
        guard case let .json(json) = body else
        {
            Log.error("Invliad JSON in the body")
            return nil
        }
        return [:]
        

    }
    
    func send(_ response:RouterResponse, data: JSON?) {
        do{
            if let jsonResponse = data
            {
                try response.status(.OK).send(json: data).end()

            }
            else
            {
                try response.status(.OK).end()
            }
        }catch
        {
            Log.error("Failed to Send response")
        }
    }
    
    init() {
        
        //Unique path
        let idPath = "api/todos/:id"

        //Any request given will go though the parser
        router.all("/*",middleware: BodyParser())
        router.all("/*",middleware: AllRemoteOriginMiddleware())
        router.options("/*") { (request, response, next) in
            response.headers["Access-Control-Allow-Headers"] = "accept, conet-type"
            response.headers["Access-Control-Allow-Methods"] = "GET,HEAD,POST,DELETE,OPTIONS,PUT,PATCH"
            
            //Everything went ok
            response.status(.OK)
            next()
        }
        
        router.get("/", handler: getAll)
        router.get(idPath, handler: getIndividual)
        router.post("/", handler: createTodo)
        router.post(idPath, handler: updateByID)
        router.patch(idPath,handler: updateByID)
        router.delete(idPath,handler: deleteByID)
        router.delete("/",handler: deleteAll)
        Log.logger = HeliumLogger()


        Kitura.addHTTPServer(onPort: 8080, with: router)
        Kitura.run()
        
    }
    
    func getAll(request: RouterRequest, response: RouterResponse, next:  ()->Void) {
        
        let todos = self.list.getAll()
        self.send(response, data: JSON(todos.jsonDictionary))
        
    
    }
    

    func getIndividual(request: RouterRequest, response: RouterResponse, next:  ()->Void) {
        guard let todoID = request.parameters["id"] else
        {
            Log.error("No id passed in")
            response.status(.badRequest)
            return
        }
        guard let todo = self.list.getTodo(with: todoID) else
        {
            return
        }
        
        self.send(response, data: JSON(todo.jsonDictionary))
        
    
    }
    func createTodo(request: RouterRequest, response: RouterResponse, next:  ()->Void) {
        guard let json = self.collectJSONBody(request: request) else
        {
            Log.error("Invalid JSON")
            response.status(.badRequest)
            return
        }
        
        guard let title = json["title"].string else
        {
            Log.error("No title in JSON")
            response.status(.badRequest)
            return
            
        }
        
        let order = json["order"].int
        let completd = json["complted"].bool
        
        let item = self.list.add(with: title, order: order, completed: completd)
        self.send(response, data: JSON(item.jsonDictionary))
        

    }
    
    
    func updateByID(request: RouterRequest, response: RouterResponse, next:  ()->Void) {
        guard let json = self.collectJSONBody(request: request) else
        {
            Log.error("Invalid JSON")
            response.status(.badRequest)
            return
        }
        
        guard let id = request.parameters["id"] else
        {
            Log.error("No id")
            response.status(.badRequest)
            return
        }
        
        let title = json["title"].string
        let order = json["order"].int
        let completed = json["completed"].bool
        
        guard let todo = self.list.updateTodo(with: id, title: title, order: order, completed: completed) else {
            Log.error("Unable to update that todo")
            response.status(.internalServerError)
            return
        }
        self.send(response, data: JSON(todo.jsonDictionary))
        
    }
    func deleteByID(request: RouterRequest, response: RouterResponse, next:  ()->Void) {
    
        guard let id = request.parameters["id"] else
        {
            Log.error("No id")
            response.status(.badRequest)
            return
        }
        self.list.deleteTodo(with: id)
        
        
    }
    func deleteAll(request: RouterRequest, response: RouterResponse, next:  ()->Void) {
        self.list.deleteAll()
        self.send(response, data: nil)
    }
    
    
    
}







