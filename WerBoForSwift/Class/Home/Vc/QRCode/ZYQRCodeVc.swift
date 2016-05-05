//
//  ZYQRCodeVc.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/4.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit
import AVFoundation

class ZYQRCodeVc: UIViewController{

    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var containView: UIView!

    @IBOutlet weak var scanLabel: UILabel!
    
    //初始化
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ----life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.startAnimation()
        
        self.startScan()
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.layer.removeAllAnimations()
        session.stopRunning()
    }
    
    //MARK: ----二维码参数
    
    private lazy var session: AVCaptureSession = AVCaptureSession()  ////输入输出的中间桥梁
    
    private lazy var input: AVCaptureDeviceInput? = {     //创建输入流
        //获取摄像设备
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do{
            let input = try AVCaptureDeviceInput(device: device)
            return input
        }catch
        {
            print(error)
            return nil
        }
    }()
    
    
    private lazy var output: AVCaptureMetadataOutput = {   //创建输出流
        let output = AVCaptureMetadataOutput()
        //设置代理 在主线程里刷新
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_global_queue(0, 0))
        return output
        
    }()
    
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {   //二维码的预览图层
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        previewLayer.frame = UIScreen.mainScreen().bounds
        return previewLayer
    }()
    
    
    //MARK: ----setup
    private func setupNavigationBar()
    {
        navigationItem.title = "扫一扫"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "clickLeftItem")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "相册", style: UIBarButtonItemStyle.Plain, target: self, action: "clickRightItem")
    }
    
    //MARK: ----click
    
    @objc private func clickLeftItem()
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func clickRightItem()
    {
        openAlbum()
    }
    
    @IBAction func clickMyCardBtn(sender: AnyObject) {
        
        let vc = ZYMyCardVc()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: ----扫描二维码相关操作
    
    
    /**
    开始扫码
    */
    private func startScan()
    {
        if (!session.canAddInput(input))
        {
            return
        }
        
        if (!session.canAddOutput(output))
        {
            return
        }
        
        session.addInput(input)
        session.addOutput(output)
        
        //设置输出能够解析的数据类型
        // 注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        
        //设置有效扫描区域(源生的扫描是没有只能扫一张码的，所以最好设置下扫描范围)
        let scanCtop = fetchScanCrop(containView.frame, readerViewBounds: view.frame)
        output.rectOfInterest = scanCtop;
        
        
        //添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        
        //开始扫描
        session.startRunning()
        
    }
    
    private func startAnimation()
    {
        view.layer.removeAllAnimations()
        topConstraint.constant = -195
        view.layoutIfNeeded()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.0001 * (Double)(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            
            
            UIView.animateWithDuration(0.8) { () -> Void in
                self.topConstraint.constant = 195
                UIView.setAnimationRepeatCount(MAXFLOAT)
                self.view.layoutIfNeeded()
            }
        }
    }
    
}

//MARK: ----二维码扫描的代理以及相关方法
extension ZYQRCodeVc: AVCaptureMetadataOutputObjectsDelegate{    //用于处理采集信息的代理
    
    //MARK: ----获取扫描区域的比例关系
    private func fetchScanCrop(rect: CGRect, readerViewBounds: CGRect) ->CGRect
    {
        let x = (CGRectGetHeight(readerViewBounds) - CGRectGetHeight(rect)) / 2 / CGRectGetHeight(readerViewBounds) - 0.1
        
        let y = (CGRectGetWidth(readerViewBounds) - CGRectGetWidth(rect)) / 2 / CGRectGetWidth(readerViewBounds) - 0.1
        
        let width = CGRectGetHeight(rect) / CGRectGetHeight(readerViewBounds) + 0.1
        
        let height = CGRectGetWidth(rect) / CGRectGetWidth(readerViewBounds) + 0.1
        
        return CGRectMake(x, y, width, height)
    }
    
    
    //MARK: ----读取二维码图片
    private func readQRCodeFromImage(image: UIImage)
    {
        //初始化一个检测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [ CIDetectorAccuracy : CIDetectorAccuracyHigh ])
        
        //监测到的结果数组
        let features = detector.featuresInImage(CIImage(CGImage: image.CGImage!))
        
        if (features.count >= 1)
        {
            /**结果对象 */
            /**结果对象 */
            
            
            let feature = features.first as! CIQRCodeFeature
            let scannedResult = feature.messageString;
            
            let url: NSURL? =  NSURL(string: scannedResult)
            
            if (url != nil)
            {
                self.session.stopRunning()
                let vc = ZYWebDealVc()
                vc.url = url!
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else
            {
                let alertView = UIAlertView(title: "扫描结果", message: scannedResult, delegate: nil, cancelButtonTitle: "确定")
                alertView.show()
            }
            
            
        }
        else
        {
            let alertView = UIAlertView(title: "提示", message: "该图片没有包含一个二维码!", delegate: nil, cancelButtonTitle: "确定")
            alertView.show()
        }
        
    }
    
    //MARK: ----AVCaptureMetadataOutputObjectsDelegate
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        if (metadataObjects.count <= 0 || metadataObjects.first == nil)
        {
            return
        }
        
        
//        print(metadataObjects.first!.stringValue)
        
        var onceToken: dispatch_once_t = 0
        
        dispatch_once(&onceToken) { () -> Void in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.scanLabel.text = metadataObjects.first!.stringValue
                
                let url: NSURL? =  NSURL(string: metadataObjects.first!.stringValue)
                
                if (url != nil)
                {
                    self.session.stopRunning()
                    let vc = ZYWebDealVc()
                    vc.url = url!
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                
                
            }
        }
    }
    
}

//MARK: ----打开相册以及其代理等相关方法
extension ZYQRCodeVc: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //打开相册
    private func openAlbum()
    {
        if (!UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary))
        {
            let alertView = UIAlertView(title: "提示", message: "设备不支持访问相册，请在设置->隐私->照片中进行设置！", delegate: nil, cancelButtonTitle: "确定")
            alertView.show()
            
            return
        }
        
        let photoVc = UIImagePickerController()
        photoVc.delegate = self
        
        
        /**
        *  
        UIImagePickerControllerSourceTypePhotoLibrary,相册
        UIImagePickerControllerSourceTypeCamera,相机
        UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
        */
        
        photoVc.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        
        //设置转场动画
        photoVc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        presentViewController(photoVc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //取出图片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        weak var tempVc = self
        
        picker.dismissViewControllerAnimated(true, completion: {
            () -> Void in
            tempVc!.readQRCodeFromImage(image)
        })
        
    }
}

