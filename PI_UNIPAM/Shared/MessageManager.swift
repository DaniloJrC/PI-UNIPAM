//
//  MessageManager.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 25/04/22.
//

import SwiftMessages

struct MessageManager {
  private static var messageConfig: SwiftMessages.Config {
    var config = SwiftMessages.defaultConfig
    config.presentationContext = .automatic
    config.duration = .seconds(seconds: 5)
    config.presentationStyle = .top
    config.interactiveHide = true
    return config
  }
  
  static func showWarning(title: String, subtitle: String) {
    let messageView = MessageView(messageType: .warning, title: title, subtitle: subtitle)
    SwiftMessages.show(config: messageConfig, view: messageView)
  }
  
  static func showError(title: String, subtitle: String) {
    let messageView = MessageView(messageType: .error, title: title, subtitle: subtitle)
    SwiftMessages.show(config: messageConfig, view: messageView)
  }
  
  static func showSuccess(title: String, subtitle: String) {
    let messageView = MessageView(messageType: .success, title: title, subtitle: subtitle)
    SwiftMessages.show(config: messageConfig, view: messageView)
  }
}
