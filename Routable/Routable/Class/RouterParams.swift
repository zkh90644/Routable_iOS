//
//  RouterParams.swift
//  Routable
//
//  Created by zkhCreator on 7/16/16.
//  Copyright © 2016 zkhCreator. All rights reserved.
//

import UIKit

class RouterParams {
    private var routerOptions:ZKRouterOptions?
    private var openParams:Dictionary<String,Any>?
    private var extraParams:Dictionary<String,Any>?
    private var controllerParams:Dictionary<String,Any>?{
        get{
            var temp = Dictionary<String,Any>()
            
            if openParams == nil {
                print("openParams is not init,It's empty")
            }else{
                for (key,value) in openParams! {
                    temp.updateValue(value, forKey: key)
                }
            }
            
            if extraParams == nil{
                print("extraParams is not init,It's empty")
            }else{
                for (key,value) in extraParams! {
                    temp.updateValue(value, forKey: key)
                }
            }
            
            return temp
        }
    }
    
    init(routerOptions:ZKRouterOptions, openParams:Dictionary<String,Any>?, extraParams:Dictionary<String,Any>?) {
        self.routerOptions = routerOptions
        self.openParams = openParams
        self.extraParams = extraParams
    }
    
    
}
