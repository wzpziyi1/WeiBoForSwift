//
//  ZYPoperVc.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/3.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYPoperVc: UIViewController{

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ----life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        tableView.delegate = self
//        tableView.dataSource = self
    }

    //MARK: ----lazy
    
    
    
}

//extension ZYPoperVc: UITableViewDelegate, UITableViewDataSource{
//    //MARK: ----UITableViewDataSource
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int
//    {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return 20
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
//    {
//        return UITableViewCell()
//    }
//    
//    //MARK: ----UITableViewDelegate
//}
