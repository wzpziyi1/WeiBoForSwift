//
//  ZYWebDealVc.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/5.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYWebDealVc: UIViewController {

    
    var url: NSURL! {
        didSet{
            setupWebView()
        }
    }
    
    

    private lazy var webView: UIWebView = UIWebView()
    
    
    init(){
        super.init(nibName: "ZYWebDealVc", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        
        
    }
    
    private func setupNavigationBar()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ZYWebDealVc.clickLeftItem))
    }
    
    private func setupWebView()
    {
        webView.frame = UIScreen.mainScreen().bounds
        view.addSubview(webView)
        
        webView.delegate = self
        
        
        let request = NSURLRequest(URL: url)
        
        webView.loadRequest(request)
    }
    
    @objc private func clickLeftItem()
    {
        navigationController?.popToRootViewControllerAnimated(true)
    }

}

extension ZYWebDealVc: UIWebViewDelegate {
    
}
