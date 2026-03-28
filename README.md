# WebViewSDK

`WebViewSDK` is an iOS SDK that allows a native iOS application to connect to a web app using `WKWebView`. It injects session and user data into the web layer, listens for messages sent back from the web app, and supports native notification handling.

## Features

- Load a web application inside a native iOS app using `WKWebView`
- Pass user and session data from iOS to the web app
- Receive messages from the web app through a JavaScript bridge
- Handle notification events triggered by the web layer
- Dismiss the SDK view on error events sent by the web app 

## Requirements

- iOS
- Xcode
- Swift
- WebKit framework

## Project Structure

- `InitializeSdkViewController` — Main SDK view controller that loads the web app in a `WKWebView` and handles communication with JavaScript
- `config` — Stores SDK configuration such as user ID, session ID, auth token, and account data
- `NotificationManager` — Handles local notification presentation and user interaction
- `JSONResponse` and `NotificationMessage` — Models used to decode messages received from the web app 

## How It Works

The SDK uses `WKWebView` to open a given web URL. When the web page loads, the SDK injects a JavaScript payload containing:

- `userId`
- `authToken`
- `sessionId`

This data is sent from the native app to the web app using `window.postMessage(...)`. 

The SDK also registers a script message handler named `observer` to receive messages back from the web app. Based on the incoming message type, it can:

- Dismiss the screen when the type is `error`
- Show a native notification when the type is `notification` 

## Installation

Add the SDK/framework to your iOS project, then import it where needed:

```swift
import WebViewSDK

