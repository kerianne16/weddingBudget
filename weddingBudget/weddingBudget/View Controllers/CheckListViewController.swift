//
//  CheckListViewController.swift
//  weddingBudget
//
//  Created by Keri Levesque on 4/27/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit
import CoreData
import SwiftUI



struct HomeTasksView: View {
      // Core Data property wrappers
      @Environment(\.managedObjectContext) var managedObjectContext
      
      // The ToDo class has an `allToDoFetchRequest` function that can be used here
      @FetchRequest(fetchRequest: Checklist.getAllCheckListItems()) var listItems: FetchedResults<Checklist>
      @State var selectedTask: Checklist? = nil
      
      @State var showingSheet: Bool = false
      @State var selectedDate = Date()
      var appDelegate = UIApplication.shared.delegate as? AppDelegate
      
      var presentSheet: ActionSheet {
          ActionSheet(
              title: Text("Todo Actions"),
              message: nil,
              buttons: [
                  CompleteButton,
                  NotifyButton,
                  ActionSheet.Button.cancel({
                      self.showingSheet.toggle()
                  })])
      }
      
      var CompleteButton: ActionSheet.Button {
          ActionSheet.Button.default(Text("Mark as Complete")) {
              self.completeTask(task: self.selectedTask)
              self.showingSheet.toggle()
          }
      }
      
      var NotifyButton: ActionSheet.Button {
          ActionSheet.Button.default(Text(self.selectedTask?.isNotify == false ? "Enable Notification" : "Disable Notification")) {
              self.toggleNotifySettings(task: self.selectedTask)
              self.showingSheet.toggle()
          }
      }
      
      var body: some View {
          NavigationView {
              List {
                  Section(header: AddNewToDoTaskHeaderView().environment(\.managedObjectContext, self.managedObjectContext)) {
                      ForEach(self.listItems) { todo in
                          Button(action: {
                              self.selectedTask = todo
                              self.showingSheet = true
                          }) {
                              TaskRow(item: todo,todayDate: self.selectedDate)
                          }
                          .listRowBackground(self.rowBackgroundColor(dueDate: todo.due))
                      } .onDelete { (indexSet) in
                          let toDoDelete = self.listItems[indexSet.first!]
                          self.managedObjectContext.delete(toDoDelete)
                          try! self.managedObjectContext.save()
                      }
                      .onMove(perform: move)
                  }
              }.navigationBarTitle(Text("Checklist").font(.largeTitle))
                  .navigationBarItems(trailing: EditButton())
                  .edgesIgnoringSafeArea(.bottom)
          }.actionSheet(isPresented: $showingSheet, content: {
              presentSheet
          })
      }
      
      func rowBackgroundColor(dueDate: Date) -> Color {
          return dueDate.isEqual(currentDate: self.selectedDate) ? Color.green : dueDate.isPast(today: self.selectedDate) ? Color.yellow : Color.pink
      }
      
      func move(from sourceIndex: IndexSet, to destination: Int) {
          let toMoveTask = self.listItems[sourceIndex.first!]
          let toDestination = self.listItems[destination]
          print(toMoveTask, toDestination)
          try! self.managedObjectContext.save()
      }
      
      func toggleNotifySettings(task: Checklist?) {
          guard let index = checkTasksAvailable(task: task).first else { return }
          if self.listItems[index].isNotify == false {
              self.appDelegate?.scheduleNotification(notificationType: self.listItems[index])
              self.listItems[index].isNotify.toggle()
              print(self.listItems[index])
          } else {
              self.listItems[index].isNotify.toggle()
              print(self.listItems[index])
          }
         try! self.managedObjectContext.save()
      }
      
      func completeTask(task: Checklist?) {
          guard let task = task else { return }
          let indexes = self.listItems.indexes(of: task)
          let toDoDelete = self.listItems[indexes.first!]
          self.managedObjectContext.delete(toDoDelete)
          try! self.managedObjectContext.save()
      }
      
      func checkTasksAvailable(task: Checklist?) -> [Int] {
          guard let task = task else { return [] }
          return self.listItems.indexes(of: task)
      }
      
      func returnTodoByDate(dateString: String) -> Checklist? {
          let toDoArr = self.listItems.filter { "\($0.due)" == "\(dateString)" }
          return toDoArr.first
      }
  }

class CheckListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

//  struct HomeTasksView: View {
//        // Core Data property wrappers
//        @Environment(\.managedObjectContext) var managedObjectContext
//
//        // The ToDo class has an `allToDoFetchRequest` function that can be used here
//        @FetchRequest(fetchRequest: ChecklistItem.getAllCheckListItems()) var listItems: FetchedResults<ChecklistItem>
//        @State var selectedTask: ChecklistItem? = nil
//
//        @State var showingSheet: Bool = false
//        @State var selectedDate = Date()
//        var appDelegate = UIApplication.shared.delegate as? AppDelegate
//
//        var presentSheet: ActionSheet {
//            ActionSheet(
//                title: Text("Todo Actions"),
//                message: nil,
//                buttons: [
//                    CompleteButton,
//                    NotifyButton,
//                    ActionSheet.Button.cancel({
//                        self.showingSheet.toggle()
//                    })])
//        }
//
//        var CompleteButton: ActionSheet.Button {
//            ActionSheet.Button.default(Text("Mark as Complete")) {
//                self.completeTask(task: self.selectedTask)
//                self.showingSheet.toggle()
//            }
//        }
//
//        var NotifyButton: ActionSheet.Button {
//            ActionSheet.Button.default(Text(self.selectedTask?.isNotify == false ? "Enable Notification" : "Disable Notification")) {
//                self.toggleNotifySettings(task: self.selectedTask)
//                self.showingSheet.toggle()
//            }
//        }
//
//        var body: some View {
//            NavigationView {
//                List {
//                    Section(header: AddNewToDoTaskHeaderView().environment(\.managedObjectContext, self.managedObjectContext)) {
//                        ForEach(self.listItems) { todo in
//                            Button(action: {
//                                self.selectedTask = todo
//                                self.showingSheet = true
//                            }) {
//                                TaskRow(item: todo,todayDate: self.selectedDate)
//                            }
//                            .listRowBackground(self.rowBackgroundColor(dueDate: todo.due))
//                        } .onDelete { (indexSet) in
//                            let toDoDelete = self.listItems[indexSet.first!]
//                            self.managedObjectContext.delete(toDoDelete)
//                            try! self.managedObjectContext.save()
//                        }
//                        .onMove(perform: move)
//                    }
//                }.navigationBarTitle(Text("Tasks").font(.largeTitle))
//                    .navigationBarItems(trailing: EditButton())
//                    .edgesIgnoringSafeArea(.bottom)
//            }.actionSheet(isPresented: $showingSheet, content: {
//                presentSheet
//            })
//        }
//
//        func rowBackgroundColor(dueDate: Date) -> Color {
//            return dueDate.isEqual(currentDate: self.selectedDate) ? Color.green : dueDate.isPast(today: self.selectedDate) ? Color.yellow : Color.pink
//        }
//
//        func move(from sourceIndex: IndexSet, to destination: Int) {
//            let toMoveTask = self.listItems[sourceIndex.first!]
//            let toDestination = self.listItems[destination]
//            print(toMoveTask, toDestination)
//            try! self.managedObjectContext.save()
//        }
//
//        func toggleNotifySettings(task: ChecklistItem?) {
//            guard let index = checkTasksAvailable(task: task).first else { return }
//            if self.listItems[index].isNotify == false {
//                self.appDelegate?.scheduleNotification(notificationType: self.listItems[index])
//                self.listItems[index].isNotify.toggle()
//                print(self.listItems[index])
//            } else {
//                self.listItems[index].isNotify.toggle()
//                print(self.listItems[index])
//            }
//           try! self.managedObjectContext.save()
//        }
//
//        func completeTask(task: ChecklistItem?) {
//            guard let task = task else { return }
//            let indexes = self.listItems.indexes(of: task)
//            let toDoDelete = self.listItems[indexes.first!]
//            self.managedObjectContext.delete(toDoDelete)
//            try! self.managedObjectContext.save()
//        }
//
//        func checkTasksAvailable(task: ChecklistItem?) -> [Int] {
//            guard let task = task else { return [] }
//            return self.listItems.indexes(of: task)
//        }
//
//        func returnTodoByDate(dateString: String) -> ChecklistItem? {
//            let toDoArr = self.listItems.filter { "\($0.due)" == "\(dateString)" }
//            return toDoArr.first
//        }
//    }

}

extension FetchedResults where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
