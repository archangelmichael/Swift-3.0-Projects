//
//  KeychainWrapper.swift
//  KeychainAccess
//
//  Created by Radi on 7/10/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class MyKeychainWrapper: NSObject {
    
    public enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }
    
    static let accessServiceName : String = "UConnect"
    static let accessGroup : String = "P4JVA28GY3.com.oryx.shared.keychain"
    static let accessKey : String = "certificate-key"
    
    static func saveKey(value: String?) throws {
        guard let valueData = value?.data(using: String.Encoding.utf8) else {
            throw KeychainError.unexpectedPasswordData
        }
        
        var addQuery = getKeychainQuery()
        addQuery[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlocked
        addQuery[kSecValueData as String] = valueData as AnyObject
        
        let resultCode = SecItemAdd(addQuery as CFDictionary, nil)
        guard resultCode == noErr else {
            if resultCode == -25299 { // already exists
                try self.updateKey(value: value)
                return
            }
            else {
                throw KeychainError.unhandledError(status: resultCode)
            }
        }
    }
    
    static func loadKey() throws -> String {
        var loadQuery = self.getKeychainQuery()
        loadQuery[kSecMatchLimit as String] = kSecMatchLimitOne
        loadQuery[kSecReturnAttributes as String] = kCFBooleanTrue
        loadQuery[kSecReturnData as String] = kCFBooleanTrue
        
        var result: AnyObject?
        let resultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(loadQuery as CFDictionary,
                                UnsafeMutablePointer($0))
        }
        
        guard resultCode != errSecItemNotFound else { // -25300
            throw KeychainError.noPassword
        }
        
        guard resultCode == noErr else {
            throw KeychainError.unhandledError(status: resultCode)
        }
        
        // Parse the password string from the query result.
        guard let existingItem = result as? [String : AnyObject],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData,
                                  encoding: String.Encoding.utf8)
            else {
                throw KeychainError.unexpectedPasswordData
        }
        
        return password
    }
    
    static func updateKey(value: String?) throws {
        guard let valueData = value?.data(using: String.Encoding.utf8) else {
            throw KeychainError.unexpectedPasswordData
        }
        
        let updateQuery = self.getKeychainQuery()
        var attributesToUpdate = [String : AnyObject]()
        attributesToUpdate[kSecValueData as String] = valueData as AnyObject?
        
        let resultCode = SecItemUpdate(updateQuery as CFDictionary,
                                       attributesToUpdate as CFDictionary)
        
        guard resultCode == noErr else {
            throw KeychainError.unhandledError(status: resultCode)
        }
    }
    
    static func deleteKey() throws {
        let deleteQuery = self.getKeychainQuery()
        let resultCode = SecItemDelete(deleteQuery as CFDictionary)
        guard resultCode == noErr || resultCode == errSecItemNotFound else { //  -25300 not found
            throw KeychainError.unhandledError(status: resultCode)
        }
    }
    
    private static func getKeychainQuery() -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = accessServiceName as AnyObject?
        query[kSecAttrAccount as String] = accessKey as AnyObject?
        query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        return query
    }
}
