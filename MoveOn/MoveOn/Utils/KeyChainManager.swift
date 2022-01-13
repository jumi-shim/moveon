//
//  KeyChainManager.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/13.
//

import Foundation
import Security

class KeyChainManager {
    func create(service:String, account:String, value:String) -> Bool {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecAttrGeneric: value
        ]
        
        return errSecSuccess == SecItemAdd(query, nil)
    }
    
    func read(service:String, account:String) -> String? {
        let query:NSDictionary = [
            kSecClass:kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecReturnAttributes: true,
            kSecMatchLimit: kSecMatchLimitOne]
        
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess {print("1");return nil}
        guard let existingItem = item as? [String:Any],
              let data = existingItem[kSecAttrGeneric as String] as? String else{print("2"); return nil}
        
        return data
    }
    
    func delete(service:String, account:String) -> Bool {
        let query:NSDictionary = [
            kSecClass:kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]
        return errSecSuccess == SecItemDelete(query)
    }
}
