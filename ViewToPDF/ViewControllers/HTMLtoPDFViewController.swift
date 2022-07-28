//
//  HTMLtoPDFViewController.swift
//  ViewToPDF
//
//  Created by Shayne Torres on 7/27/22.
//
//  source: https://gist.github.com/nyg/b8cd742250826cb1471f

import Foundation
import UIKit
import PDFKit
import SwiftUI

class HTMLtoPDFViewController: PDFViewerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUI() {
        super.setUI()
        
        createPDF()
    }
    
    override func createPDF() {
        // 1. Create a print formatter
        // Load the invoice HTML template code into a String variable.
        var html = ""
        do {
            html = try String(contentsOfFile: Bundle.main.path(forResource: "ReportTemplate_HTML", ofType: "html") ?? "")
        } catch {
            print("Could not find HTML file")
            return
        }

        let fmt = UIMarkupTextPrintFormatter(markupText: html)

        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)

        // 3. Assign paperRect and printableRect
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")

        // 4. Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)

        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage();
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }

        UIGraphicsEndPDFContext();

        // 5. Save PDF file
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("output").appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }

        pdfData.write(to: outputURL, atomically: true)
        
        if let writtenDoc = PDFDocument(url: outputURL) {
            print("Log: Successfully aquired PDF from url!")
            self.pdfViewer.document = writtenDoc
        } else {
            print("Log: Could not create PDF file from url (\(outputURL)")
        }
    }
}

struct HTMLtoPDFView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return HTMLtoPDFViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
