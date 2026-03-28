//
//  InitializeSdkViewController.swift
//  WebViewSDK
//
//  Created by Usama on 12/05/22.
//

import UIKit
import WebKit
import UserNotifications

public class InitializeSdkViewController: UIViewController {
    
    public var config: config!
    private var webView = WKWebView()
    private let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadWebViewWithPfmconfig(Url: url)
    }
    
    public override func loadView() {
        super.loadView()
        webView = WKWebView(frame: .zero, configuration: self.getWKWebViewConfiguration())
        view = webView
        setWebViewConstraints()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    private func loadWebViewWithPfmconfig(Url: URL) {
        webView.load(URLRequest(url: Url))
    }
    
    private func setWebViewConstraints() {
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func getWKWebViewConfiguration() -> WKWebViewConfiguration {
        
        let userController = WKUserContentController()
        userController.add(self, name: "observer")
        
        let scriptSource = "window.postMessage({consumerId: '\(self.config.getUserId())', authToken: '\(self.config.getSessionToken())', sessionId: '\(self.config.getSession())', accounts: '\(self.config.getAccountsArrayString())'})"
        
        // Instantiate a WKUserScript object and specify when you’d like to inject your script
        // and whether it’s for all frames or the main frame only.
        let userScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        userController.addUserScript(userScript)
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.userContentController = userController
        
        return configuration
    }
    
    private func showNotification(notificationDetails: NotificationMessage) {
        NotificationManager.shared.sendNotification(title: notificationDetails.title, body: notificationDetails.text, badge: 1, delayInterval: nil)
    }
}

extension InitializeSdkViewController: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard let JSONbody = message.body as? String else { return }
        print(message.name)
        print(message.body)
        print(JSONbody)
        let result = convertStringToDictionary(text: JSONbody)
        guard let responseType = result?["type"] as? String else { return }
        
        switch responseType {
        case "error":
            self.dismiss(animated: true)
        case "notification":
            guard let data = JSONbody.data(using: .utf8) else { return }
            let value: JSONResponse = try! JSONDecoder().decode(JSONResponse.self, from: data)
            showNotification(notificationDetails: value.message)
        default:
            print("Default case.")
        }
    }
}
