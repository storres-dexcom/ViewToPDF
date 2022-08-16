//
//  SimpleLineChartView.swift
//  ViewToPDF
//
//  Created by Shayne Torres on 8/16/22.
//

import Foundation
import UIKit
import SwiftUI
import Charts

struct DisplayEGV {
    var id: String
    var time: Date
    var value: Double
    
    static var testEGVs: [DisplayEGV] = [
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 1), value: 100),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 2), value: 120),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 3), value: 130),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 4), value: 140),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 5), value: 150),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 6), value: 160),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 7), value: 150),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 8), value: 150),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 9), value: 160),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 10), value: 120),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 11), value: 130),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 12), value: 120),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 13), value: 150),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 14), value: 160),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 15), value: 200),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 16), value: 150),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 17), value: 120),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 18), value: 100),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 19), value: 100),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 20), value: 120),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 21), value: 140),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 22), value: 130),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 23), value: 100),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 24), value: 80),
        .init(id: UUID().uuidString, time: Date(year: 2022, month: 8, day: 25), value: 60)
    ]
}

struct ChartUtil {
    static func getEGVLineDataSet(start: Double, end: Double, height: Double) -> [ChartDataEntry] {
        return [
            ChartDataEntry(x: start, y: height),
            ChartDataEntry(x: end, y: height)
        ]
    }
}

struct SimpleLineChartView: UIViewRepresentable {
    var egvs: [DisplayEGV]
    
    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        let chartEGVs = egvs.map { ChartDataEntry(x: $0.time.timeIntervalSince1970, y: $0.value) }
        // DataSet options
        let dataSet = LineChartDataSet(entries: chartEGVs, label: "EGVs")
        dataSet.setColor(.black)
        dataSet.drawCirclesEnabled = false
        
        let highEGVLineSet = LineChartDataSet(entries: ChartUtil.getEGVLineDataSet(start: Date(year: 2022, month: 8, day: 1).timeIntervalSince1970,
                                                                                   end: Date(year: 2022, month: 8, day: 25).timeIntervalSince1970,
                                                                                   height: 180))
        highEGVLineSet.setColor(.orange)
        highEGVLineSet.drawCirclesEnabled = false
        let lowEGVLineSet = LineChartDataSet(entries: ChartUtil.getEGVLineDataSet(start: Date(year: 2022, month: 8, day: 1).timeIntervalSince1970,
                                                                                   end: Date(year: 2022, month: 8, day: 25).timeIntervalSince1970,
                                                                                   height: 90))
        lowEGVLineSet.setColor(.red)
        lowEGVLineSet.drawCirclesEnabled = false
        
        // Char options
        uiView.data = LineChartData(dataSets: [
            dataSet,
            highEGVLineSet,
            lowEGVLineSet
        ])
        uiView.xAxis.labelPosition = .bottom
        uiView.xAxis.valueFormatter = LineChartXAxisNameFormater()
        uiView.rightAxis.drawLabelsEnabled = false
    }
}

struct SimpleLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleLineChartView(egvs: DisplayEGV.testEGVs)
    }
}

extension Date {
    init(year: Int, month: Int, day: Int,
          hour: Int = 0, minute: Int = 0, second: Int = 0,
          nanosecond: Int = 0) {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond
        self = calendar.date(from: components)!
    }
}

final class LineChartXAxisNameFormater: IndexAxisValueFormatter {

    override func stringForValue( _ value: Double, axis _: AxisBase?) -> String {

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMM.dd"

        return formatter.string(from: Date(timeIntervalSince1970: value))
    }

}
