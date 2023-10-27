
import AuthenticationServices

public func keychain_save(_ data: Data, service: String, account: String) {
    let query = [
        kSecValueData: data,
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ] as CFDictionary
        
    let saveStatus = SecItemAdd(query, nil)
 
    if saveStatus != errSecSuccess {
        print("Error: \(saveStatus)")
    }
    
    if saveStatus == errSecDuplicateItem {
        keychain_update(data, service: service, account: account)
    }
}
 
public func keychain_update(_ data: Data, service: String, account: String) {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ] as CFDictionary
        
    let updatedData = [kSecValueData: data] as CFDictionary
    SecItemUpdate(query, updatedData)
}


public func keychain_read(service: String, account: String) -> Data? {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account,
        kSecReturnData: true
    ] as CFDictionary
        
    var result: AnyObject?
    SecItemCopyMatching(query, &result)
    return result as? Data
}
 
public func keychain_delete(service: String, account: String) {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ] as CFDictionary
        
    SecItemDelete(query)
}
 
