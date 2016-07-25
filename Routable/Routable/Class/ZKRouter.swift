//
//  ZKRouter.swift
//  Routable
//
//  Created by zkhCreator on 7/16/16.
//  Copyright © 2016 zkhCreator. All rights reserved.
//

import UIKit

typealias RouterOpenCallBack = (Dictionary<String,Any>)->()

enum RouterError:ErrorType {
    case FormatEmpty(String)
    case ViewControllerNil(String)
    case RouteNotFoundException(String)
    
}

//重新定义两个变量为结构体
struct RouterOptions{
    var modal:Bool = false
    var presentationStyle:UIModalPresentationStyle = .None
    var transitionStyle:UIModalTransitionStyle = .CoverVertical
    var defaultParams = Dictionary<String,Any>()
    var shouldOpenAsRootViewController:Bool = false
    
    var callback:RouterOpenCallBack?
    var className:AnyClass?
}

struct RouterParams {
    var routerOptions = RouterOptions()
    var openParams = Dictionary<String,String>()
    var extraParams = Dictionary<String,Any>()
    var controllerParams:Dictionary<String,Any>{
        get{
            var temp = Dictionary<String,Any>()
            
            for (key,value) in routerOptions.defaultParams {
                temp.updateValue(value, forKey: key)
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
}


class ZKRouter {
    
    let navigationController:UINavigationController
    var ignoresExceptions:Bool = false
    
    private var routes = Dictionary<String,RouterOptions>()
    private var cacheRoutes = Dictionary<String,RouterParams>()
    
    init(nav:UINavigationController){
        self.navigationController = nav
    }

    func map(format:String,callback:(RouterOpenCallBack?),options:RouterOptions = RouterOptions.init()) throws{
        guard format == "" else {
            throw RouterError.FormatEmpty("The format is empty,this value shoule not be empty")
        }
        
        var tempOptions = options
        tempOptions.callback = callback
        
        self.routes.updateValue(tempOptions, forKey: format);
    }
    
    func map(format:String,toClassName:AnyClass,options:RouterOptions = RouterOptions.init()) throws{
        guard format == "" else {
            throw RouterError.FormatEmpty("The format is empty,this value shoule not be empty")
        }
        
        var tempOptions = options
        tempOptions.className = toClassName
        
        self.routes.updateValue(options, forKey: format)
    }
    
    func openExternal(url:String) {
        UIApplication.sharedApplication().openURL(NSURL.init(string: url)!)
    }
    
    
    
    func routerParams(url:String,extraParams:Dictionary<String,Any>? = nil) throws -> RouterParams?{
        let givenParts = url.characters.split("/").map(String.init)

        var openParams:RouterParams?
        for item in self.routes {
            let routerUrl = item.0
            let routerOptions = item.1

            let routerParts = routerUrl.characters.split("/").map(String.init)
            if routerParts.count == givenParts.count{
                let givenParams = self.getParamsFromUrlComponent(givenParts, routerUrlComponents: routerParts)
                
                if givenParams != nil{
                    if extraParams == nil {
                        openParams = RouterParams.init(routerOptions: routerOptions, openParams: givenParams!, extraParams: Dictionary<String,Any>())
                    }else{
                        openParams = RouterParams.init(routerOptions: routerOptions, openParams: givenParams!, extraParams: extraParams!)
                    }
                    break;
                }
            }
            if openParams == nil {
                if self.ignoresExceptions {
                    return nil
                }else{
                    throw RouterError.RouteNotFoundException("No route found for URL \(url)")
                }
            }
        }
        self.cacheRoutes.updateValue(openParams!, forKey: url)
        
        return openParams
    }
    
    func initControllerView(params:RouterParams) -> UIViewController {
        
        var vc = UIViewController.init(nibName: nil, bundle: nil)
        
        let className = params.routerOptions.className

        if className?.superclass {
            <#code#>
        }
        
        return vc
    }
    
    func getParamsFromUrlComponent(givenUrlCompents:Array<String>,routerUrlComponents:Array<String>) -> Dictionary<String,String> {
        var params = Dictionary<String,String>()
        var idx = 0

        for routerComponent in routerUrlComponents {
            let givenComponent = givenUrlCompents[idx]
            if routerComponent.hasPrefix(":") {
                if params != nil{
                    let index = routerComponent.startIndex.advancedBy(1)
                    let key:String = routerComponent.substringFromIndex(index)
                    params!.updateValue(givenComponent, forKey: key)
                }else{
                    params = Dictionary<String,String>()
                    let index = routerComponent.startIndex.advancedBy(1)
                    let key:String = routerComponent.substringFromIndex(index)
                    params!.updateValue(givenComponent, forKey: key)
                }
            }else if routerComponent == givenComponent{
                params = nil
                break ;
            }
            idx += 1;
        }
        return params
    }
    
    
}
