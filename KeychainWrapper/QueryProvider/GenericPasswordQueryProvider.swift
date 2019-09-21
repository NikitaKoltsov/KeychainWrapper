//
//  GenericPasswordQueryProvider.swift
//  KeychainWrapper
//
//  Created by Nikita Koltsov on 9/21/19.
//  Copyright © 2019 NIkita  Koltsov. All rights reserved.
//

import Foundation
import Security

public struct GenericPasswordQueryProvider {
  let service: String
  let accessGroup: String?
  
  public init(service: String, accessGroup: String? = nil) {
    self.service = service
    self.accessGroup = accessGroup
  }
}

extension GenericPasswordQueryProvider: KeychainQueryProvider {
  public func query(for operation: KeychainOperation) -> [String: Any] {
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassGenericPassword
    query[String(kSecAttrService)] = service
    #if !targetEnvironment(simulator)
    if let accessGroup = accessGroup {
      query[String(kSecAttrAccessGroup)] = accessGroup
    }
    #endif
    return query
  }
}
