//
//  FourthViewController.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import AVFoundation

class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let player = AVPlayer.init(playerItem: AVPlayerItem(url: URL.init(string: "http://vt1.doubanio.com/201609291737/4af83e686c0432c0dbd3c320f14eba6f/view/movie/M/302030039.mp4")!))
        let layer = AVPlayerLayer.init(player: player)
        layer.videoGravity = .resizeAspect
        layer.frame = CGRect(x: 20, y: 0, width: self.view.bounds.size.width, height: 200)
        self.view.layer.addSublayer(layer)
        player.play()
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
