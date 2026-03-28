//
//  JSONResponse.swift
//  WebViewSDK
//
//  Created by Usama on 11/22/22.
//

import Foundation

struct JSONResponse: Decodable {
    let action: String
    let type: URL
    let message: NotificationMessage
}
