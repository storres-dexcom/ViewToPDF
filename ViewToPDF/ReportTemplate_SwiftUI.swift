//
//  ReportTemplate_SwiftUI.swift
//  ViewToPDF
//
//  Created by Shayne Torres on 7/27/22.
//

import SwiftUI

struct ReportTemplate_SwiftUI: View {
    var body: some View {
        VStack(alignment: .leading) {
            // Image
            HStack {
                Image("ic_dexcom_logo")
                Spacer()
            }
            
            // Header
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Overview").bold()
                    Text("5 days").font(.system(size: 12).bold()) + Text(" | Start Date - End Date").font(.system(size: 12))
                }
                Spacer()
                Text("Dexcom Apollo").bold()
            }
            // EGV Stats
            HStack(alignment: .top) {
                EGVStatItem(title: "Avg Low", value: "120")
                EGVStatItem(title: "Very Low", value: "0.0%")
                EGVStatItem(title: "Low", value: "0.0%")
                EGVStatItem(title: "In Target Range", value: "98.6%")
                EGVStatItem(title: "High", value: "1.4%")
                EGVStatItem(title: "Very High", value: "0.0%")
            }
            .font(.system(size: 12).bold())
            .padding(.top)
            SimpleLineChartView(egvs: DisplayEGV.testEGVs)
                .frame(height: 200)
                .padding(.top, 30)
            Spacer()
        }
        .padding(20)
    }
}

extension ReportTemplate_SwiftUI {
    struct EGVStatItem: View {
        var title: String
        var value: String
        
        var body: some View {
            VStack(alignment: .center) {
                Text(title)
                    .padding(.bottom)
                Text(value)
            }
            .frame(maxWidth: .infinity)
            .font(.system(size: 8).bold())
        }
    }
}

struct ReportTemplate_SwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ReportTemplate_SwiftUI()
    }
}
