//
//  Message.swift
//  TableCellAutoHeightWebView
//
//  Created by Radi on 9/26/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class Message: NSObject {

    static let dateFormatter = DateFormatter()
    
    var id : Int64
    var created : Date
    var author : String
    
    var title : String
    var html : String
    var text : String
    var avatar : String?
    
    var liked : Bool
    var likesCount : Int64
    
    var tags : Array<String> = []
    
    init?(fromJson : Dictionary<String, AnyObject>) {
        
        guard let idValue = fromJson["id"],
            let dateValue = fromJson["date_created"] as? String,
            let likedValue = fromJson["liked"],
            let likedCountValue = fromJson["count_likes"],
            let htmlValue = fromJson["text"] as? String,
            let usernameValue = (fromJson["user"] as! Dictionary<String, String>)["username"],
            let tagsValue = fromJson["tags"] as? Array<String>
            else {
                print("!!! MESSAGE Parsing error !!!")
                return nil
        }
        
        self.id = idValue.int64Value
        
        Message.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let parsedDate = Message.dateFormatter.date(from: dateValue) {
            self.created = parsedDate
        }
        else {
            return nil
        }
        
        self.title = "message"
        self.html = "<h1>html<\\h1>"
        self.text = "text"
        
        self.liked = likedValue.boolValue
        self.likesCount = likedCountValue.int64Value
        self.html = htmlValue
        self.author = usernameValue
        
        self.avatar = nil
        if let avatarUrl = fromJson["image_url"] as? String {
            self.avatar = avatarUrl
        }
        
        self.tags.removeAll()
        self.tags = Array(tagsValue)
    }
}
