//
//  ContentView.swift
//  ViewToPDF
//
//  Created by Shayne Torres on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: UIViewToPDFView()) {
                    Text("UIView Render")
                }
                NavigationLink(destination: SwiftUIViewToPDFView()) {
                    Text("SwiftUI Render")
                }
                NavigationLink(destination: HTMLtoPDFView()) {
                    Text("HTML Render")
                }
            }.navigationTitle("PDF Generators")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
