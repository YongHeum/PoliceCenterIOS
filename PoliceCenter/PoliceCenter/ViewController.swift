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

        // //추가
        // webView.configuration.preferences.javaScriptEnabled = true //자바스크립트 활성화 
        
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    // //추가
    // override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() } //모달창 닫힐때 앱 종료현상 방지.
    
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

    // //추가
    // //confirm 처리
    // func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
    //     let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
    //     alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
    //     alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
    //     self.present(alertController, animated: true, completion: nil) }
    
    // // href="_blank" 처리
    // func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
    //     if navigationAction.targetFrame == nil { webView.load(navigationAction.request) }
    //     return nil }
}
