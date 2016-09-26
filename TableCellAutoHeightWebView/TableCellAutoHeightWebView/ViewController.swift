//
//  ViewController.swift
//  TableCellAutoHeightWebView
//
//  Created by Radi on 9/26/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tvMessages: UITableView!
    
    var messages : Array<Message> = []
    var rowHeights : Dictionary<String, CGFloat> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        self.loadMessages()
    }
    
    func setupTable() -> Void {
        self.tvMessages.dataSource = self
        self.tvMessages.delegate = self
        self.tvMessages.separatorStyle = UITableViewCellSeparatorStyle.none
        
//        self.tvMessages.rowHeight = UITableViewAutomaticDimension
//        self.tvMessages.estimatedRowHeight = 160.0
        
        let webCellNib = UINib(nibName: "WebTableViewCell", bundle: Bundle.main)
        self.tvMessages.register(webCellNib, forCellReuseIdentifier: "webCell")
    }
    
    func loadMessages() -> Void {
        self.messages.removeAll()
        
        do {
            let file = Bundle.main.path(forResource: "messages", ofType: "json")
            let url = URL(fileURLWithPath: file!)
            let data = try Data(contentsOf: url)
            let json : Dictionary<String, AnyObject> = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
            if let jsonMessages = json["messages"] as? Array<Dictionary<String, AnyObject>> {
                for jsonMessage in jsonMessages {
                    let message = Message.init(fromJson: jsonMessage)
                    if message != nil {
                        self.messages.append(message!)
                    }
                }
                
                print("OK")
            }
            else {
                print("!!! DATA Parsing error !!!")
            }
        }
        catch {
            print("!!! JSON parsing error !!!")
        }
        
        if self.messages.count > 0 {
            var parsedMessages : Array<Message> = []
            parsedMessages.append(contentsOf: self.messages)
            self.messages.removeAll()
            
            var counter = 30
            while counter > 0 {
                for msg in parsedMessages {
                    self.messages.append(msg)
                }
                
                counter-=1
            }
        }
    }
    
    @IBAction func onReload(_ sender: AnyObject) {
        self.tvMessages.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let linksColor = "#FF00FF"
        let javascripString = "var list = document.getElementsByTagName('a'); for (var i = 0; i < list.length; i++) { list[i].style.color = '\(linksColor)';}"
        webView.stringByEvaluatingJavaScript(from: javascripString)
        
        // Get message for this web view
        var msg : Message? = nil
        if let cell = webView.superview?.superview as? WebTableViewCell {
            let rowPath = self.tvMessages.indexPath(for: cell)
            if rowPath != nil && rowPath!.row >= 0 && rowPath!.row < self.messages.count { // Row is valid
                msg = self.messages[rowPath!.row]
            
                if msg != nil { // There is message
                    if let wvHeight = self.rowHeights["\(msg!.id)"] { // Height is already calculated for this message
                        webView.alpha = 1.0
                    }
                    else { // Calculate new height for message
                        let rowHeight = webView.scrollView.contentSize.height + WebTableViewCell.defaultHeight
                        self.rowHeights["\(msg!.id)"] = rowHeight
                        self.tvMessages.reloadRows(at: [rowPath!], with: UITableViewRowAnimation.fade)
                    }
                }
                else {
                    // TODO
                    // No message for row
                }
            }
            else {
                // TODO
                // Invalid index path
            }
        }
        else {
            // TODO
            // Cannot get web view cell
        }
    }
    
    func webView(_ webView: UIWebView,
                 shouldStartLoadWith request: URLRequest,
                 navigationType: UIWebViewNavigationType) -> Bool {
        
        return true;
    }
}

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = self.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "webCell") as! WebTableViewCell
        cell.wvContent.alpha = 0.0
        cell.wvContent.delegate = self
        cell.wvContent.loadHTMLString(msg.html, baseURL: nil)
        
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    // Implement delegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        if self.messages.count == 0 || row < 0 || row >= self.messages.count  {
            return WebTableViewCell.defaultHeight
        }
        
        let msg = self.messages[row]
        let rowHeight = self.rowHeights["\(msg.id)"]
        return rowHeight == nil ? WebTableViewCell.defaultHeight : rowHeight!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

