//
//  ZYOAuthVC.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/6.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYOAuthVC: UIViewController {

    
    //新浪appkey
    let ZYXLAppKey = "3722612068"
    
    //新浪App Secret
    let ZYXLAppSecret = "dd877b1d3dadeb885597937e5e70a492"
    
    //回调网页
    let ZYXLRedirectUri = "http://www.cnblogs.com/"
    
    //调用authorize获得的code值。
    var code: String!
    
    private lazy var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        
        setupWebView()
        
    }
    
    private func setupNavigationBar()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ZYOAuthVC.clickLeftItem))
        
    }
    
    private func setupWebView()
    {
        webView.frame = UIScreen.mainScreen().bounds
        
        webView.delegate = self
        
        view.addSubview(webView)
        
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(ZYXLAppKey)&redirect_uri=\(ZYXLRedirectUri)")
        let request = NSURLRequest(URL: url!)
        
        webView.loadRequest(request)
        
    }
    
    private func fetchToken()
    {
        let params = ["client_id" : ZYXLAppKey, "client_secret" : ZYXLAppSecret, "grant_type" : "authorization_code", "code" : code, "redirect_uri" : ZYXLRedirectUri]
        
        ZYNetworkTool.sharedNetworkTool().POST(kApiAccessToken, parameters: params, success: { (_, json) -> Void in
            let dict = json as! Dictionary<String, AnyObject>
            let info = ZYLoginInfo(dict: dict)
            
            ZYSaveTool.sharedSaveTool().writeLoginInfo(info)
            
            NSNotificationCenter.defaultCenter().postNotificationName(ZYIsLoginDidChangeNotification, object: nil, userInfo: [ZYIsLoginKey: NSNumber(bool: true)])
            
            self.clickLeftItem()
            
            }) { (_, error) -> Void in
                print(error)
        }
    }
    
    @objc private func clickLeftItem()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension ZYOAuthVC: UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        
        let matchStr: NSString = "?code="
        
        if ((request.URL?.absoluteString.hasPrefix(ZYXLRedirectUri) == true) && (request.URL?.absoluteString.containsString(matchStr as String) == true) )
        {
            let subStr = (request.URL?.absoluteString.stringByReplacingOccurrencesOfString(ZYXLRedirectUri, withString: ""))! as NSString
            
            code = subStr.substringFromIndex(matchStr.length)
            fetchToken()
            return false
        }
        
        return  true
    }
    
}


