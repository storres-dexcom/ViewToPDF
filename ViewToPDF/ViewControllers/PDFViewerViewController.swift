//
//  PDFViewerViewController.swift
//  ViewToPDF
//
//  Created by Shayne Torres on 7/27/22.
//

import Foundation
import UIKit
import SwiftUI
import PDFKit

class PDFViewerViewController: UIViewController {
    
    var pdfViewer = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        view.addSubview(pdfViewer)
        pdfViewer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pdfViewer.topAnchor.constraint(equalTo: view.topAnchor),
            pdfViewer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pdfViewer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pdfViewer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func createPDF(from view: UIView) {}
    
    func createPDF() {}
}
