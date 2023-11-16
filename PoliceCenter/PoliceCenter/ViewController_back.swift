//
//  ViewController.swift
//  PoliceCenter
//
//  Created by LST on 11/15/23.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    private let url = "http://20.214.166.57/member/login"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        
        webViewInit()
    }
    
    // 웹뷰 실행
    func webViewInit(){
        webView.allowsBackForwardNavigationGestures = true
        
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

// 웹뷰 관련 Extension
extension ViewController: WKUIDelegate {
    
    // 새 웹뷰 생성
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        return WKWebView(frame: webView.frame, configuration: configuration)
    }
    
    // 웹뷰 Alert 설정
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert);
        
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in
            completionHandler()
        }
        
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
