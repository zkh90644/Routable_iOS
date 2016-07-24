//
//  ZKRouterOptions.swift
//  Routable
//
//  Created by zkhCreator on 7/16/16.
//  Copyright © 2016 zkhCreator. All rights reserved.
//

import UIKit

typealias RouterOpenCallBack = (Dictionary<String,Any>?)->()

class ZKRouterOptions {
//    是否以modal的形式转换
    var modal:Bool = false
//    该方法在PAD上面会产生区别，在手机上都是直接从下面跳出来的效果
    var presentationStyle:UIModalPresentationStyle = .None
//    modal的转换方法
    var transitionStyle:UIModalTransitionStyle = .CoverVertical
//    用来设置每次默认需要传的值
    var defaultParams:Dictionary<String,Any>?
//    是否设置为根VC
    var shouldOpenAsRootViewController:Bool = false
    
    
//    回调函数
    var callback:RouterOpenCallBack?
//    当前这个VC的类型
    var openClass:AnyClass?
    
//MARK:INIT

    init(presentationStyle:UIModalPresentationStyle,transitionStyle:UIModalTransitionStyle,defaultParams:Dictionary<String,Any>?,isRoot:Bool,isModal:Bool){
        self.presentationStyle = presentationStyle
        self.transitionStyle = transitionStyle
        self.defaultParams = defaultParams
        self.shouldOpenAsRootViewController = isRoot
        self.modal = isModal
        self.callback = nil
    }
    
    convenience init(){
        self.init(presentationStyle:.None,transitionStyle:.CoverVertical,defaultParams:nil ,isRoot:false,isModal:false)
    }
    
    convenience init(style:UIModalPresentationStyle){
        self.init(presentationStyle:style,transitionStyle:.CoverVertical,defaultParams:nil ,isRoot:false,isModal:false)
    }
    
    convenience init(style:UIModalTransitionStyle){
        self.init(presentationStyle:.None,transitionStyle:style,defaultParams:nil ,isRoot:false,isModal:false)
    }
    
    convenience init(defaultParams:Dictionary<String,Any>?){
        self.init(presentationStyle:.None,transitionStyle:.CoverVertical,defaultParams:defaultParams ,isRoot:false,isModal:false)
    }
    
    convenience init(modal:Bool){
        self.init(presentationStyle:.None,transitionStyle:.CoverVertical,defaultParams:nil ,isRoot:false,isModal:modal)
    }
    
    convenience init(root:Bool){
        self.init(presentationStyle:.None,transitionStyle:.CoverVertical,defaultParams:nil ,isRoot:root,isModal:false)
    }
    
    static func initModal() -> ZKRouterOptions{
        return ZKRouterOptions.init(modal: true);
    }
    
    static func initWithRoot() -> ZKRouterOptions{
        return ZKRouterOptions.init(root: true)
    }
    
}
