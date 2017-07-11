//
//  ViewController.swift
//  EncryptDecrypt
//
//  Created by Radi on 7/11/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Generation of RSA private and public keys
        let parameters: [String: AnyObject] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String: 1024 as AnyObject
        ]
        
        var publicKey, privateKey: SecKey?
        
        SecKeyGeneratePair(parameters as CFDictionary,
                           &publicKey,
                           &privateKey)
        
        //Encrypt a string with the public key
        let message = "This is my message."
        let blockSize = SecKeyGetBlockSize(publicKey!)
        var messageEncrypted = [UInt8](repeating: 0,
                                       count: blockSize)
        var messageEncryptedSize = blockSize
        var status: OSStatus!
        
        status = SecKeyEncrypt(publicKey!,
                               SecPadding.PKCS1,
                               message,
                               message.characters.count,
                               &messageEncrypted,
                               &messageEncryptedSize)
        
        if status != noErr {
            print("Encryption Error!")
            return
        }
        
        print(messageEncrypted)
        
        //Decrypt the entrypted string with the private key
        var messageDecrypted = [UInt8](repeating: 0,
                                       count: blockSize)
        var messageDecryptedSize = messageEncryptedSize
        
        status = SecKeyDecrypt(privateKey!,
                               SecPadding.PKCS1,
                               &messageEncrypted,
                               messageEncryptedSize,
                               &messageDecrypted,
                               &messageDecryptedSize)
        
        if status != noErr {
            print("Decryption Error!")
            return
        }
        
        print(NSString(bytes: &messageDecrypted,
                       length: messageDecryptedSize,
                       encoding: String.Encoding.utf8.rawValue)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

