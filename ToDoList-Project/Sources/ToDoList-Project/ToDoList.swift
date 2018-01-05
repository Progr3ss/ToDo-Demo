//
//  ToDoList.swift
//  ToDoList-Project
//
//  Created by Martin Chibwe on 1/3/18.
//

import Foundation
import CloudFoundryEnv
import CloudEnvironment
import Configuration
struct ToDoItem
{
    let todoID: String
    let order: Int?
    let title: String
    let completed: Bool?
    
}
typealias JSONDictionary = [String: Any]
protocol JSONAble {
    var jsonDictionary: JSONDictionary{get}
    
}
extension ToDoItem : JSONAble
{
    var jsonDictionary: JSONDictionary {
        let manager = ConfigurationManager()
        manager.load(.environmentVariables)
        let url = manager.url + "/api/todos/" + self.todoID
        var dictionary = JSONDictionary()
        dictionary["id"] = self.todoID
        dictionary["order"] = self.order
        dictionary["title"] = self.title
        dictionary["url"] = url
        
        return dictionary
    }
}
extension Array where Element: JSONAble
{
    var jsonDictionary:[JSONDictionary]{
        return self.map{$0.jsonDictionary}
        
    }
}
class  TodoList
{
    var list : [ToDoItem] = [ToDoItem]()
    var counter : Int = 0
    
    func getAll() -> [ToDoItem] {
        return list
    }
    func getTodo(with id : String) -> ToDoItem? {
        let todo  = list.filter{$0.todoID == id}.first
        return todo
    }
    func add(with title :String, order: Int?, completed:Bool?) -> ToDoItem {
        let todoID = String(self.counter)
        let todo = ToDoItem(todoID: todoID, order: order, title: title, completed: completed ?? false)
        list.append(todo)
        self.counter += 1
        return todo
        
    }
    func updateTodo(with id: String, title: String, order:Int?, completed:Bool?) -> ToDoItem? {
        
        guard let index = list.index(where: {(item) -> Bool in
            item.todoID == id
        }) else {
            return nil
        
        }
        let todo = ToDoItem(todoID: id, order: order, title: title ?? self.list[index].title, completed: completed)
        self.list[index] = todo
        return todo
        
    }
    
    func deleteTodo(with id:String)  {
        guard let index = self.list.index(where: {(item) -> Bool in
            item.todoID == id
        }) else { return }
        
        self.list.remove(at: index)
    }
    func deleteAll()  {
        self.list = [ToDoItem]()
    }
}
