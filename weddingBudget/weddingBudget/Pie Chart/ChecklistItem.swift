//
//  ChecklistItem.swift
//  weddingBudget
//
//  Created by Keri Levesque on 4/30/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//
import SwiftUI
import Foundation
import CoreData


public class Checklist: NSManagedObject, Identifiable {
      @NSManaged public var title: String?
      @NSManaged public var due: Date
      @NSManaged public var isNotify: Bool
}

extension Checklist {
    static func getAllCheckListItems() -> NSFetchRequest<Checklist> {
        let request: NSFetchRequest<Checklist> = Checklist.fetchRequest() as! NSFetchRequest<Checklist>
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
