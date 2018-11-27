//
//  RadarViewController.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class RadarViewController: UIViewController, ChatPeerManagerDelegate {
  
    static let shareInstance = RadarViewController()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let buttonArray = NSMutableArray()
    var chatPeersArray = NSMutableArray ()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.appDelegate.chatViewModel.delegate = self
        self.view.backgroundColor = UIColor.black
        let radarview = RadarAnimationView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 80))
        self.view.addSubview(radarview)
        NotificationCenter.default.addObserver(self, selector: #selector(foundDevice(_:)), name: NSNotification.Name(rawValue: "RadarViewControllerFindObject"), object: nil)
        let chatPeerList = NSKeyedUnarchiver.unarchiveObject(withFile: peerIDFilePath)
        if chatPeerList != nil {
            self.chatPeersArray = NSMutableArray.init(array: chatPeerList as! NSArray)
        }
        self.showMembers(array: self.chatPeersArray)
       
    }
    
    
  @objc func foundDevice(_ notification: Notification) {
    let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
    let fromPeer = receivedDataDictionary["MCPeerId"] as? MCPeerID

    let chatpeerModel = ChatPeerModel()
    chatpeerModel.peer = fromPeer
    self.chatPeersArray.add(chatpeerModel)
//    self.chatPeersArray.removeAllObjects()
//    let chatPeerList = NSKeyedUnarchiver.unarchiveObject(withFile: peerIDFilePath)
//    if chatPeerList != nil {
//        self.chatPeersArray = NSMutableArray.init(array: chatPeerList as! NSArray)
//    }

    showMembers(array: self.chatPeersArray)

    }
 
    //MARK: 出现头像
    func showMembers(array: NSMutableArray){
       
        for view in self.view.subviews {
            if (view.isKind(of: UIButton.self)){
                view.removeFromSuperview()
            }
            
        }
       for (i, lopper) in array.enumerated() {
            let button = UIButton(type: .custom)
            button.backgroundColor = UIColor.clear
            button.tag = i + 1000
            repeat {
             button.frame = randomFrameForButton()
            }while (self.frameIntersects(frame: button.frame))
            button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
            self.buttonArray.add(button)
        
        
            let imageView = UIImageView.init()
            imageView.backgroundColor = UIColor.gray
            imageView.layer.cornerRadius = 20
            imageView.layer.masksToBounds = true
            imageView.image = UIImage(named: "other")
            let label = UILabel.init()
            label.textColor = .white
            label.text = (lopper as! ChatPeerModel).peer.displayName
            label.font = UIFont.systemFont(ofSize: 12)
        
            button.addSubview(imageView)
            button.addSubview(label)
            self.view.addSubview(button)
            imageView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.width.height.equalTo(40)
            }
            label.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp.bottom)
                make.bottom.equalToSuperview()
                make.right.left.equalToSuperview()
            }
        }
    }
    
    //查询坐标是否重复
    func frameIntersects(frame: CGRect) -> Bool {
        for button in self.buttonArray {
            if frame.intersects((button as! UIButton).frame) {
                return true
            }
        }
        return false
    }
    
    
    //获取随机坐标
    func randomFrameForButton() -> CGRect {
       let maxWidth = self.view.bounds.size.width - 60.0
       let maxHeight = self.view.bounds.size.height - 65.0
       var startX: CGFloat
       var startY: CGFloat
       var finish: Bool = true
       repeat {
          startX = CGFloat(arc4random() % UInt32(maxWidth))
          startY = CGFloat(arc4random() % UInt32(maxHeight))
        if (startX < (self.view.center.x - 60 - 25) ||  startX > (self.view.center.x + 25)) {
           finish = false
        } else if(startY < (self.view.center.y - 65 - 25) || startY > (self.view.center.y + 25) && startY < (self.view.bounds.size.height - tabbarHeight - 65)) {
           finish = false
        }
        
       }while (finish)
        
       return CGRect(x: startX, y: startY, width: 60, height: 65)
        
    }
    
    
    
    
    
    //点击进行聊天
    @objc func buttonClick(button: UIButton) {
       let i = button.tag - 1000
       let model: ChatPeerModel = self.chatPeersArray[i] as! ChatPeerModel
       if self.appDelegate.chatViewModel.newSession!.connectedPeers.contains(model.peer) == false {
            self.appDelegate.chatViewModel.browser.invitePeer(model.peer, to:  self.appDelegate.chatViewModel.newSession!, withContext: nil, timeout: 10)
        }
       let chattingVC = ChattingViewController()
       chattingVC.title = model.peer.displayName
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.pushViewController(chattingVC, animated: true)
        }
    }
    
    
    
    func foundPeer(_ peer: MCPeerID) {
    
    }
    
    func lostPeer(_ peer: MCPeerID) {
        print("RadarView lost peerID")
        let newChatPeersArray = self.chatPeersArray
        for (i, lopper) in newChatPeersArray.enumerated() {
            DispatchQueue.main.async {
                let button = self.view.viewWithTag(i + 1000)
                button?.removeFromSuperview()
            }
            if (lopper as! ChatPeerModel).peer == peer {
              self.chatPeersArray.remove(lopper)
            }
        }
        
        showMembers(array: self.chatPeersArray)
    }
    
    func invitationWasReceived(fromPeer: MCPeerID) {
        
    }
    
    func connectedWithPeer(_ peer: MCPeerID) {
        
    }
    
    func reloadData() {
        
    }
    
}
