//
//  UIViewToPDFViewController.swift
//  ViewToPDF
//
//  Created by Shayne Torres on 7/26/22.
//

import Foundation
import UIKit
import SwiftUI
import PDFKit

class UIViewToPDFViewController: PDFViewerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUI() {
        super.setUI()
        
        var yPosition: CGFloat = 0
        
        let documentView = UIView(frame: PageType.a4.size)
        
        yPosition += 40
        let image = UIImage(named: "ic_dexcom_logo")
        let imageView = UIImageView(frame: .init(x: PageType.a4.margin, y: yPosition, width: 80, height: 40))
        yPosition += 40
        imageView.image = image
        imageView.contentMode = .topLeft
        documentView.addSubview(imageView)
        
        yPosition += 20
        let titleStack = UIStackView(frame: .init(x: PageType.a4.margin, y: yPosition, width: PageType.a4.marginedWidth, height: 30))
        documentView.addSubview(titleStack)
        
        let titleLabel = UILabel()
        titleLabel.text = "Session Report"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleStack.addArrangedSubview(titleLabel)
        yPosition += 30
        
        yPosition += 20
        let patientInfoParentHStack = UIStackView(frame: .init(x: PageType.a4.margin, y: yPosition, width: PageType.a4.marginedWidth, height: 75))
        patientInfoParentHStack.axis = .horizontal
        documentView.addSubview(patientInfoParentHStack)
        yPosition += 75
        
        let patientInfoChildVStack = UIStackView()
        patientInfoChildVStack.axis = .vertical
        patientInfoChildVStack.distribution = .equalSpacing
        patientInfoParentHStack.addArrangedSubview(patientInfoChildVStack)
        
        let patientName = UILabel()
        patientName.text = "Name: John Doe"
        patientInfoChildVStack.addArrangedSubview(patientName)
        
        let patientMRN = UILabel()
        patientMRN.text = "MRN: ########"
        patientInfoChildVStack.addArrangedSubview(patientMRN)
        
        let patientDOB = UILabel()
        patientDOB.text = "DOB: 05-23-1977"
        patientInfoChildVStack.addArrangedSubview(patientDOB)

        yPosition += 20
        let colorHStack = UIStackView(frame: .init(x: PageType.a4.margin, y: yPosition, width: PageType.a4.marginedWidth, height: 60))
        colorHStack.axis = .horizontal
        colorHStack.distribution = .fillEqually
        documentView.addSubview(colorHStack)
        
        let redView = UIView()
        redView.backgroundColor = .red
        colorHStack.addArrangedSubview(redView)
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        colorHStack.addArrangedSubview(blueView)
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        colorHStack.addArrangedSubview(greenView)
        yPosition += 60
        
        createPDF(from: documentView)
    }
    
    override func createPDF(from view: UIView) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputFileURL = documentDirectory.appendingPathComponent("MyUIViewPDF.pdf")
        print("URL:", outputFileURL) // When running on simulator, use the given path to retrieve the PDF file
        
        let format = UIGraphicsPDFRendererFormat()
        let metadata = [kCGPDFContextTitle: "Patient Session Report",
                        kCGPDFContextAuthor: "Dexcom, Inc."] as [String: Any]
        format.documentInfo = metadata
        
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: PageType.a4.size,
                                                format: format)
        
        do {
            try pdfRenderer.writePDF(to: outputFileURL, withActions: { context in
                context.beginPage()
                view.layer.render(in: context.cgContext)
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
    }
}

struct UIViewToPDFView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return UIViewToPDFViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
