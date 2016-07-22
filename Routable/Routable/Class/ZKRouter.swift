//
//  ZKRouter.swift
//  Routable
//
//  Created by zkhCreator on 7/16/16.
//  Copyright © 2016 zkhCreator. All rights reserved.
//

import UIKit

class ZKRouter {
    private var routes = Dictionary<String,Any>()
    private var cacheRoutes = Dictionary<String,Any>()
    
    var navigationController:UINavigationController?
    var RouterParams:Bool = false
    var url:String = ""
    
    func map(format:String,callback:RouterOpenCallBack,options:ZKRouterOptions) {
        options.callback = callback
        self.routes.updateValue(options, forKey: format)
    }
    
    func map(format:String,callback:RouterOpenCallBack){
        self.map(format, callback: callback, options: ZKRouterOptions.routerOptions())
    }
    
    func map(format:String,controllerClass:AnyClass,options:ZKRouterOptions) {
        options.openClass = controllerClass
        self.routes.updateValue(options, forKey: format)
    }
    
    func map(format:String,controllerClass:AnyClass) {
        self.map(format, controllerClass: controllerClass, options: ZKRouterOptions.routerOptions())
    }
    
    func openExternal(url:String) {
        UIApplication.sharedApplication().openURL(NSURL.init(string: url)!)
    }
    
    func open(url:String,animated:Bool,extraParams:Dictionary<String,Any>) {
        <#function body#>
    }
    
    func open(url:String) {
        self.openExternal(url)
    }
    
    
}
