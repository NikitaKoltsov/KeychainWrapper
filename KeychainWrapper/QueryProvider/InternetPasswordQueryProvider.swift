//
//  InternetPasswordQueryProvider.swift
//  KeychainWrapper
//
//  Created by Nikita Koltsov on 9/21/19.
//  Copyright © 2019 NIkita  Koltsov. All rights reserved.
//

import Foundation

public struct InternetPasswordQueryProvider {
  let server: String
  let port: Int
  let path: String
  let securityDomain: String
  let internetProtocol: InternetProtocol
  let internetAuthenticationType: InternetAuthenticationType
}

extension InternetPasswordQueryProvider: KeychainQueryProvider {
  public func query(for operation: KeychainOperation) -> [String: Any] {
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassInternetPassword
    query[String(kSecAttrPort)] = port
    query[String(kSecAttrServer)] = server
    query[String(kSecAttrSecurityDomain)] = securityDomain
    query[String(kSecAttrPath)] = path
    query[String(kSecAttrProtocol)] = internetProtocol.rawValue
    query[String(kSecAttrAuthenticationType)] = internetAuthenticationType.rawValue
    return query
  }
}
