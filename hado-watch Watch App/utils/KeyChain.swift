//  KeyChainModel.swift
//  HadoWit Watch App
//
//  Created by Jonathan on 2024/6/6.
//
//  用来存储管理一个唯一的设备UUID，可以和HADO SERVER通讯保持一个唯一标记
import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()
    
    func save(key: String, data: Data) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as CFDictionary

        SecItemDelete(query)

        let status = SecItemAdd(query, nil)
        return status == errSecSuccess
    }
    
    func load(key: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary

        var dataTypeRef: AnyObject? = nil

        let status = SecItemCopyMatching(query, &dataTypeRef)
        if status == errSecSuccess {
            return dataTypeRef as? Data
        }
        return nil
    }
    
    func delete(key: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary

        SecItemDelete(query)
    }
}
