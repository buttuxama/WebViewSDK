//
//  Helper.swift
//  WebViewSDK
//
//  Created by Usama on 11/24/22.
//

import Foundation


public class config {
    
    private var session : String = ""
    private var baseUrl : String = ""
    private var userid : String = ""
    private var ssl_cert_name : String = ""
    private var ssl_domain_name : String = ""
    private var accountsArrayString : String = ""
    private var accountsURL : String = ""
    private var session_token = ""
    private var bank_session_id = ""
        
    public init(userid: String, session: String, authToken: String, accountsArrayString: String) {
        self.userid = userid
        self.session = session
        self.session_token = authToken
        self.accountsArrayString = accountsArrayString
    }
    
    open func getAccountsArrayString() -> String  {
        return accountsArrayString
    }
    
    open func setBaseUrl (baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    open func setAccountsUrl(accountUrl: String) {
        self.accountsURL = accountUrl
    }
    
    open func setSessionToken(token: String) {
        self.session_token = token
    }
    
    open func getSessionToken() -> String {
        return self.session_token
    }
    
    open func setBankSessionId(id: String) {
        self.bank_session_id = id
    }
    
    open func getBankSessionId() -> String {
        return self.bank_session_id
    }
   
    open func getSession () -> String {
        return session
    }
    
    open func getBaseUrl () -> String {
        return baseUrl
    }
    
    public func getUserId () -> String {
        return userid
    }
    
    open func setSslCertName (certName: String) {
        self.ssl_cert_name = certName
    }
    
    public func getSslCertName () -> String {
        return ssl_cert_name
    }
    
    open func setSslDomainName (domainName: String) {
        self.ssl_domain_name = domainName
    }
    
    public func getSslDomainName () -> String {
        return ssl_domain_name
    }
}

public func convertStringToDictionary(text: String) -> [String:Any]? {
    if let data = text.data(using: .utf8) {
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
            return jsonDictionary
        } catch {
            print("Something went wrong.")
        }
    }
    return nil
}
