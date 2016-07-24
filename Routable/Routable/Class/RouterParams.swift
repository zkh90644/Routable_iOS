//
//  RouterParams.swift
//  Routable
//
//  Created by zkhCreator on 7/16/16.
//  Copyright © 2016 zkhCreator. All rights reserved.
//

import UIKit

class RouterParams {
//    routerOptions为页面转换的方式
    var routerOptions:ZKRouterOptions
//    openParams为url中的不一样的值组成的dic,如果两个界面需要区分的话，基本页面需要为name/:,后一个页面为name/:需要的值
    private var openParams:Dictionary<String,String>
//    extraParams为VC切换的我们想要传递过去的值
    private var extraParams:Dictionary<String,Any>
//    上面两个之和，回调+切换时候创建的，一般在创建的时候作为参数传递过去。
    var controllerParams:Dictionary<String,Any>{
        get{
            var temp = Dictionary<String,Any>()
            
            if routerOptions.defaultParams != nil {
                for (key,value) in routerOptions.defaultParams! {
                    temp.updateValue(value, forKey: key)
                }
            }
            
            for (key,value) in openParams {
                temp.updateValue(value, forKey: key)
            }
            
            for (key,value) in extraParams {
                temp.updateValue(value, forKey: key)
            }
            
            return temp
        }
    }
    
    init(routerOptions:ZKRouterOptions = ZKRouterOptions.init(), openParams:Dictionary<String,String> = Dictionary<String,String>(), extraParams:Dictionary<String,Any> = Dictionary<String,Any>()) {
        self.routerOptions = routerOptions
        self.openParams = openParams
        self.extraParams = extraParams
    }
    
    
}
