//
//  ViewController.swift
//  socketrocket-task
//
//  Created by mahmoud aziz on 29/09/2021.
//

import UIKit
import SocketRocket

class ViewController: UIViewController, SRWebSocketDelegate {
    
    var socketURL = URLRequest(url: URL(string: "wss://em.alqemam.com/ET_ios_Final_v9.6.00/Handlers/ETSocketHandler.ashx/getCPSettingValue")!)
    
    var socket: SRWebSocket?
    
    let json: [String:Any] = [
//        "userToken": "",
        "actionName": "getCPSettingValue",
        "cpSettingArr": ["show_login_logo"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(socket?.readyState ?? "")
        
        let string = stringify(json: json)
        
        if socket?.readyState != .OPEN {
            socket = SRWebSocket(urlRequest: socketURL as URLRequest)
            socket?.delegate = self
            socket?.open()
        } else {
            print(socket?.readyState ?? "")
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            do {
//                try self.socket?.send(string: string)
//                print("socket sent")
//            }
//            catch {
//                print(error.localizedDescription)
//            }
//        }
    }
    
    
    func webSocketDidOpen(_ webSocket: SRWebSocket) {
        print("socket opened")
        do {
            
            let string = stringify(json: json)
            try self.socket?.send(string: string)
            print("socket sent")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func webSocket(_ webSocket: SRWebSocket, didCloseWithCode code: Int, reason: String?, wasClean: Bool) {
        print("code: \(code) reason:\(reason ?? "") ")
    }
    
    func webSocket(_ webSocket: SRWebSocket, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    private func webSocket(webSocket: SRWebSocket!, didReceiveMessage message: AnyObject!) {
        print("received message")
    }
    
    func stringify(json: [String:Any]) -> String {
        
        var options: JSONSerialization.WritingOptions = []
        
        options = JSONSerialization.WritingOptions.prettyPrinted
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        return ""
    }
    
    
}
