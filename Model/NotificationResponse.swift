//
//  NotificationResponse.swift
//  WebViewSDK
//
//  Created by Usama on 11/22/22.
//

import Foundation

struct NotificationMessage : Decodable {
    let text: String
    let title: String
}
