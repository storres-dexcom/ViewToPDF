//
//  SwiftUIViewToPDFViewController.swift
//  ViewToPDF
//
//  Created by Shayne Torres on 7/27/22.
//

import Foundation
import UIKit
import SwiftUI
import PDFKit

class SwiftUIViewToPDFViewController: PDFViewerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func setUI() {
        super.setUI()
        
        createPDF()
    }
    
    override func createPDF() {
        let myUIHostingController = UIHostingController(rootView: ReportTemplate_SwiftUI())
        myUIHostingController.view.frame = PageType.a4.size
        
        
        //Render the view behind all other views
        guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
            print("ERROR: Could not find root ViewController.")
            return
        }
        rootVC.addChild(myUIHostingController)
        //at: 0 -> draws behind all other views
        //at: UIApplication.shared.windows.count -> draw in front
        rootVC.view.insertSubview(myUIHostingController.view, at: 0)
        
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputFileURL = documentDirectory.appendingPathComponent("MySwiftUIPDF.pdf")
        print("URL:", outputFileURL) // When running on simulator, use the given path to retrieve the PDF file
        
        let format = UIGraphicsPDFRendererFormat()
        let metadata = [kCGPDFContextTitle: "Patient Session Report",
                        kCGPDFContextAuthor: "Dexcom, Inc."] as [String: Any]
        format.documentInfo = metadata
        
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: PageType.a4.size,
                                                format: format)
        DispatchQueue.main.async {
            do {
                try pdfRenderer.writePDF(to: outputFileURL, withActions: { context in
                    context.beginPage()
                    myUIHostingController.view.layer.render(in: context.cgContext)
                })
            } catch {
                print("Log: Could not create PDF file: \(error)")
            }
            
            if let writtenDoc = PDFDocument(url: outputFileURL) {
                print("Log: Successfully created PDF from url!")
                self.pdfViewer.document = writtenDoc
            } else {
                print("Log: Could not create PDF file from url (\(outputFileURL)")
            }
            
            //Remove rendered view
            myUIHostingController.removeFromParent()
            myUIHostingController.view.removeFromSuperview()
        }
        
    }
}

struct SwiftUIViewToPDFView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return SwiftUIViewToPDFViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
