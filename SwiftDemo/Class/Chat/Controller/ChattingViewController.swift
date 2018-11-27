//
//  ChattingViewController.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import RealmSwift
import SnapKit
import MultipeerConnectivity

class ChattingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    weak var textField: UITextField?
    weak var tableView: UITableView?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var chatListModel: ChatDataList = {
        return self.appDelegate.chatViewModel.getChatListFromLocalDataBaseWith(userName: self.title!)
    }()
    
    var chatFrames = [ChatViewFrame]()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 键盘位置变化观察
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillExchange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // 获取到数据通知
        NotificationCenter.default.addObserver(self, selector: #selector(handleMPCReceivedDataWithNotification), name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: nil)
        
        // 配置界面
        self.setupSubviews()
        self.navigationController?.navigationBar.isHidden = false 
        for chatData in (self.chatListModel.chatDatasArray) {
            self.setupFramesWithChatData(chatData)
        }
    }
    
    func setupSubviews() {
        
        let customTableView = UITableView()
        customTableView.allowsSelection = false
        customTableView.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        customTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.view.addSubview(customTableView)
        self.tableView = customTableView
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        customTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-44)
            make.left.right.equalToSuperview()
        }
        
        let toolView = UIView()
        self.view.addSubview(toolView)
        toolView.backgroundColor = UIColor.white
        toolView.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.left.right.bottom.equalToSuperview()
        }
        
        let voiceBtn = UIButton()
        voiceBtn.setImage(UIImage(named: "chat_bottom_voice_nor"), for: UIControl.State.normal)
        voiceBtn.setImage(UIImage(named: "chat_bottom_voice_press"), for: UIControl.State.highlighted)
        toolView.addSubview(voiceBtn)
        voiceBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(toolView.snp.height)
            make.left.top.equalToSuperview()
        }
        
        let moreToolBtn = UIButton()
        moreToolBtn.setImage(UIImage(named: "chat_bottom_up_nor"), for: UIControl.State.normal)
        moreToolBtn.setImage(UIImage(named: "chat_bottom_up_press"), for: UIControl.State.highlighted)
        toolView.addSubview(moreToolBtn)
        moreToolBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(toolView.snp.height)
            make.right.top.equalToSuperview()
        }
        
        let emojBtn = UIButton()
        emojBtn.setImage(UIImage(named: "chat_bottom_smile_nor"), for: UIControl.State.normal)
        emojBtn.setImage(UIImage(named: "chat_bottom_smile_press"), for: UIControl.State.highlighted)
        toolView.addSubview(emojBtn)
        emojBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(toolView.snp.height)
            make.top.equalToSuperview()
            make.right.equalTo(moreToolBtn.snp.left)
        }
        
        let textField = UITextField()
        textField.delegate = self
        textField.background = UIImage(named: "chat_bottom_textfield")
        toolView.addSubview(textField)
        self.textField = textField
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(voiceBtn.snp.right).offset(5)
            make.right.equalTo(emojBtn.snp.left).offset(-5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
    }
    
    //MARK:- tableview datasource & delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatFrames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ChatViewCell.chatViewCellWithTableView(tableView: tableView) as! ChatViewCell
        
        cell.chatViewFrame = self.chatFrames[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let frame: ChatViewFrame = self.chatFrames[indexPath.row]
        return frame.cellHeight!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let stateLabel = UILabel()
        stateLabel.bounds = CGRect(x: 0, y: 0, width: 100, height: 20)
        stateLabel.text = self.appDelegate.chatViewModel.onlineStateTextDict[self.title!]
        stateLabel.textAlignment = NSTextAlignment.center
        stateLabel.backgroundColor = UIColor(white: 180/255.0, alpha: 0.5)
        return stateLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    //MARK:-
    /**
     *  接收到键盘位置状态变化时调用
     */
    @objc func keyBoardWillExchange(note: NSNotification) {
        
        //0.设置window的背景图片
        self.view.window?.backgroundColor = self.tableView?.backgroundColor
        
        //1.获取键盘移动的距离
        let keyboardRect = note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let transformY = keyboardRect.origin.y - self.view.frame.size.height
        
        //2.将整个view往上移动
        UIView.animate(withDuration: 0.25, animations:{
            self.view.transform = CGAffineTransform(translationX: 0, y: transformY)
            if transformY < 0 {
                self.tableView?.contentInset = UIEdgeInsets(top: -transformY, left: 0, bottom: 0, right: 0)
            }else {
                self.tableView?.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
            }
        })
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.textField?.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.textField?.text!.characters.count == 0 {
            return false
        }
        //1.发送一条自己的消息
        self.sendOneMessage(text: (self.textField?.text)!, isSendedByMe:true)
        
        //2.更新一条消息到上一级列表
        self.sendMessage(textField.text!)
        
        self.textField?.text = "";
        
        return true;
    }
    
    /**
     *  发送一条消息
     *
     */
    func sendOneMessage(text: String, isSendedByMe flag: Bool) {
        
        //1.创建一条新的消息模型, 并将此消息存到realm数据库中
        let newChatData = ChatModel()
        newChatData.message         = text
        newChatData.chatDataByMeFlag = NSNumber(value: flag)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        newChatData.time = formatter.string(from: Date())
        
        // 将聊天记录存储到Realm数据库中
        if flag == true {
            self.appDelegate.chatViewModel.storeChatData(newChatData, with: self.title!)
        }
        
        self.setupFramesWithChatData(newChatData)
        
    }
    
    /**
     *  计算聊天信息的Frame
     */
    func setupFramesWithChatData(_ data: ChatModel) {
        //2.创建一个Frame模型
        let frame = ChatViewFrame()
        
        //3.判断是否与上一条消息所发出时间一致
        let previousData = self.chatFrames.last?.chatData
        if previousData?.time == data.time {
            frame.isTheSameTime = true
        }else {
            frame.isTheSameTime = false
        }
        
        //4.将数据模型添加至Frame模型中
        frame.chatData = data
        
        //5.将Frame模型添加至数组中
        self.chatFrames.append(frame)
        //6.刷新table表格数据
        self.tableView?.reloadData()
        
        //7.将tableView自动跳转到最后一行新数据
        let lastRow = IndexPath.init(row: self.chatFrames.count - 1, section: 0)
        self.tableView?.scrollToRow(at: lastRow, at: UITableView.ScrollPosition.top, animated: true)
    }
    
    open func receivedMessage(message: String) {
        
        self.sendOneMessage(text: message, isSendedByMe: false)
    }
    
    /**
     *  发送新消息
     */
    func sendMessage(_ message: String) {
        
        if (message.characters.count == 0) {
            return;
        }
        
        let messageDictionary: [String: String] = ["message" : message]
        
        let session = self.appDelegate.chatViewModel.myPeerSessions[self.title!]
        if  session != nil{
            for (index, onePeer) in session!.connectedPeers.enumerated() {
                if onePeer.displayName == self.title {
                    guard self.appDelegate.chatViewModel.sendData(dictionaryWithData: messageDictionary, toPeer: session!.connectedPeers[index]) else {
                        print("Could not send data!")
                        return
                    }
                }
            }
            
        }else {
            print("当前离线")
            MBProgressHUD.showFailureHUDWithMessage(message: "对方设备当前离线", andTime: 1.5)
        }
        
        
        //        if ([self.delegate respondsToSelector:@selector(chatViewControllerSendNewMessage:isToAllFlag:)])
        //        {
        //        if ([self.title isEqualToString:@"大家一起聊"]) {
        //        [self.delegate chatViewControllerSendNewMessage:message isToAllFlag:YES];
        //        }else {
        //        [self.delegate chatViewControllerSendNewMessage:message isToAllFlag:NO];
        //        }
        //        }
    }
    
    // 收到新数据处理
    @objc func handleMPCReceivedDataWithNotification(_ notification: Notification) {
        
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        let data = receivedDataDictionary["data"] as? NSData
        let fromPeer = receivedDataDictionary["fromPeer"] as? MCPeerID
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data as! Data ) as! Dictionary<String, AnyObject>
        
        if let message = dataDictionary["message"] as? String {
            if message != "_end_chat_" {
                
                OperationQueue.main.addOperation {
                    //                    let messageDictionary: [String: String] = ["sender" : (fromPeer?.displayName)!, "message" : message]
                    self.sendOneMessage(text: message, isSendedByMe: false)
                    self.tableView?.reloadData()
                }
            }else {
                
                let alert = UIAlertController(title: "", message: "\(fromPeer?.displayName)", preferredStyle: UIAlertController.Style.alert)
                
                let doneAction: UIAlertAction = UIAlertAction(title: "Okat", style: UIAlertAction.Style.default, handler: { (alertAction) in
                    self.appDelegate.chatViewModel.myPeerSessions[self.title!]?.disconnect()
                    self.dismiss(animated: true, completion: nil)
                })
                
                alert.addAction(doneAction)
                
                OperationQueue.main.addOperation {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
