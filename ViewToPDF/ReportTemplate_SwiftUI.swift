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
            
            // Title
            HStack {
                Spacer()
                Text("Session Report")
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.bottom, 4)
            
            // Patient Info
            Text("Name: John Doe")
            Text("MRN: ########")
            Text("DOB: 04-24-1977")
            
            // Color Stack
            HStack(spacing: 0) {
                Color.red
                Color.green
                Color.blue
            }.frame(height: 50)
            
            // Full Screen Spacer
            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity)
    }
}

struct ReportTemplate_SwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ReportTemplate_SwiftUI()
    }
}
