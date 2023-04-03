//
//  ToDoItem.swift
//  ToDo List
//
//  Created by 顏逸修 on 2023/4/2.
//

import Foundation


struct ToDoItem: Codable {
    var name: String
    var date: Date
    var notes: String
    var reminderSet: Bool
    var notificationID: String?
    var completed: Bool
}
