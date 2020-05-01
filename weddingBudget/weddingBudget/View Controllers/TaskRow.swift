//
//  TaskRow.swift
//  weddingBudget
//
//  Created by Keri Levesque on 4/30/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI
import Combine

struct TaskRow: View {
    @State var item: Checklist
    @State var todayDate: Date
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
            HStack {
                Text(item.title ?? "Empty")
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                    .clipped()
                    .minimumScaleFactor(0.8)
                    .lineLimit(nil)
               
                Image(systemName: item.isNotify ? "bell.fill" : "bell.slash.fill")
                    .padding()
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color.black)
            }
            Text(item.due.isEqual(currentDate: todayDate) ? "Today" : item.due.string(format: "dd-MM-yyyy"))
                .bold()
                .foregroundColor(item.due.isEqual(currentDate: todayDate) ? Color.blue : Color.blue)
                .font(.system(size: 19))
                .frame(height: 20, alignment: .trailing)
        } .padding()
    }
}
