//
//  ZYWelcomeVc.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/20.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYWelcomeVc: UIViewController {


    @IBOutlet weak var welcomeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        welcomeBtn.center.x = view.center.x
        welcomeBtn.frame.origin.y = 200
        
        beginAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickBtn(sender: AnyObject) {
        let window = UIApplication.sharedApplication().keyWindow
        window?.rootViewController = ZYTabBarVc()
    }
    
    private func beginAnimation()
    {
        let keyAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        keyAnimation.values = [NSNumber(double: 0), NSNumber(double: 1), NSNumber(double: 2), NSNumber(double: 1), NSNumber(double: 0), NSNumber(double: 1)]
        keyAnimation.duration = 2
        keyAnimation.removedOnCompletion = true
        welcomeBtn.layer.addAnimation(keyAnimation, forKey: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
