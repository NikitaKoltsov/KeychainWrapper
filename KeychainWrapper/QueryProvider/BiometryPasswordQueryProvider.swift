//
//  BiometryPasswordQueryProvider.swift
//  KeychainWrapper
//
//  Created by Nikita Koltsov on 9/21/19.
//  Copyright © 2019 NIkita  Koltsov. All rights reserved.
//

import Foundation
import LocalAuthentication
import Security

public struct BiometryPasswordQueryProvider {
  let service: String
  let accessGroup: String?
  let context: LAContext = {
    let context = LAContext()
    context.touchIDAuthenticationAllowableReuseDuration = 10
    return context
  }()
  
  public init(service: String, accessGroup: String? = nil) {
    self.service = service
    self.accessGroup = accessGroup
  }
}

extension BiometryPasswordQueryProvider: KeychainQueryProvider {
  public func query(for operation: KeychainOperation) -> [String: Any] {
    let access = SecAccessControlCreateWithFlags(nil, // Use the default allocator.
      kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
      .userPresence,
      nil) // Ignore any error.
    
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassGenericPassword
    query[String(kSecAttrService)] = service
    query[String(kSecUseAuthenticationContext)] = context
    query[String(kSecAttrAccessControl)] = access as Any
    
    switch operation {
    case .read:
      query[String(kSecUseOperationPrompt)] = "Access your password"
    default:
      query[String(kSecUseOperationPrompt)] = "Save new password"
    }
    
    #if !targetEnvironment(simulator)
    if let accessGroup = accessGroup {
      query[String(kSecAttrAccessGroup)] = accessGroup
    }
    #endif
    return query
  }
}
