//
//  PieChartViewController.swift
//  weddingBudget
//
//  Created by Keri Levesque on 4/28/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {

    //MARK: Properties
    let catergories = ["Honeymoon", "Venue", "Catering", "Photography"]
    let goals = [6, 8, 26, 30, 8, 10]
    
    
    //MARK: Outlets
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
      super.viewDidLoad()
      pieChartView.chartDescription?.text = "Wedding Budget"
      pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
      customizeChart(dataPoints: catergories, values: goals.map{ Double($0) })
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
      
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      
      // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
      
      // 3. Set ChartData
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      let format = NumberFormatter()
      format.numberStyle = .percent
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      
      // 4. Assign it to the chart's data
      pieChartView.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }

}

//MARK: to do add more user input and slider
