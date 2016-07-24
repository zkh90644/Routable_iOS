//
//  ZKRouter.swift
//  Routable
//
//  Created by zkhCreator on 7/16/16.
//  Copyright © 2016 zkhCreator. All rights reserved.
//

import UIKit

protocol UIViewControllerRouter {
    func initWithRouter(dic:Dictionary<String,Any>)
}

enum RouterError:ErrorType {
    case FormatEmpty(String)
    case ViewControllerNil(String)
    case RouteNotFoundException(String)
    
}

class ZKRouter {
//    ZKRouter中控制跳转的核心
    let navigationController:UINavigationController
    var ignoresExceptions:Bool = false
    
    private var routes = Dictionary<String,ZKRouterOptions>()
    private var cacheRoutes = Dictionary<String,RouterParams>()
    
//    创建
    init(nav:UINavigationController){
        self.navigationController = nav
    }
    
//    将将来需要跳转的界面或者回调函数存储进去。
    func map(format:String,callback:(RouterOpenCallBack?),options:ZKRouterOptions = ZKRouterOptions.init()) throws{
        guard format == "" else {
            throw RouterError.FormatEmpty("The format is empty,this value shoule not be empty")
        }
        options.callback = callback
        self.routes.updateValue(options, forKey: format);
    }
    
    func map(format:String,toController:AnyClass,options:ZKRouterOptions = ZKRouterOptions.init()) throws{
        guard format == "" else {
            throw RouterError.FormatEmpty("The format is empty,this value shoule not be empty")
        }
        
        options.openClass = toController
        self.routes.updateValue(options, forKey: format)
    }
    
//    jump to safari
    func openExternal(url:String) {
        UIApplication.sharedApplication().openURL(NSURL.init(string: url)!)
    }
    
    //    跳转到下一个VC
    func open(url:String,animated:Bool = true,extraParams:Dictionary<String,Any>? = nil) throws{
        do {
            let params = try self.routerParams(url, extraParams: extraParams)
            let options = params?.routerOptions
            if options?.callback != nil{
                options?.callback!(params?.controllerParams)
                return ;
            }
            
            let controller = try self.initControllerView(params!)
            
            if self.navigationController.presentedViewController != nil {
                self.navigationController.dismissViewControllerAnimated(animated, completion: nil)
            }
            
//            if ((options?.modal) != false) {
//                if controller.superclass?.class(UINavigationController) {
//                    <#code#>
//                }
//            }
            
        }catch{
            throw RouterError.RouteNotFoundException("No route found for URL \(url),Params It's nil")
        }
        
        
        
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
    
    func initControllerView(params:RouterParams) throws -> RouterViewController {
        
        var vc:RouterViewController?
        
        let className = params.routerOptions.openClass

        if className!.isSubclassOfClass(RouterViewController) {
            vc = RouterViewController.init(nibName: nil, bundle: nil, dic: params.controllerParams)
        }
        
        if vc == nil {
            throw RouterError.ViewControllerNil("the ViewController is nil")
        }
        
        return vc!
    }
    
    func getParamsFromUrlComponent(givenUrlCompents:Array<String>,routerUrlComponents:Array<String>) -> Dictionary<String,String>? {
        var params = Dictionary<String,String>?()
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
