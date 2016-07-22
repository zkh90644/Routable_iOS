//
//  ZKRouterOptions.swift
//  Routable
//
//  Created by zkhCreator on 7/16/16.
//  Copyright © 2016 zkhCreator. All rights reserved.
//

import UIKit

typealias RouterOpenCallBack = ()->(Dictionary<String,Any>?)

class ZKRouterOptions {
    var modal:Bool = false
    var presentationStyle:UIModalPresentationStyle = .None
    var transitionStyle:UIModalTransitionStyle = .CoverVertical
    var defaultParams:Dictionary<String,Any>?
    var shouldOpenAsRootViewController:Bool = false
    var callback:RouterOpenCallBack?
    var openClass:AnyClass
    
//MARK:INIT
    init(presentationStyle:UIModalPresentationStyle,transitionStyle:UIModalTransitionStyle,defaultParams:Dictionary<String,Any>?,isRoot:Bool,isModal:Bool){
//        super.init()
        self.presentationStyle = presentationStyle
        self.transitionStyle = transitionStyle
        self.defaultParams = defaultParams
        self.shouldOpenAsRootViewController = isRoot
        self.modal = isModal
    }
    
    static func routerOptions() -> ZKRouterOptions {
        return ZKRouterOptions.init(presentationStyle: .None, transitionStyle: .CoverVertical, defaultParams: nil, isRoot: false, isModal: false)
    }
    
    static func routerOptionsAsModal() -> ZKRouterOptions {
        return ZKRouterOptions.init(presentationStyle: .None, transitionStyle: .CoverVertical, defaultParams: nil, isRoot: false, isModal: true)
    }
    
    static func routerOptionsWithPresentationStyle(style:UIModalPresentationStyle) -> ZKRouterOptions {
        return ZKRouterOptions.init(presentationStyle: style, transitionStyle: .CoverVertical, defaultParams: nil, isRoot: false, isModal: false)
    }
    
    static func routerOptionsWithTransitionStyle(style:UIModalTransitionStyle) -> ZKRouterOptions {
        return ZKRouterOptions.init(presentationStyle: .None, transitionStyle: style, defaultParams: nil, isRoot: false, isModal: false)
    }
    
    static func routerOptionsForDefaultParams(defaultParams:Dictionary<String,Any>?) -> ZKRouterOptions {
        return ZKRouterOptions.init(presentationStyle: .None, transitionStyle: .CoverVertical, defaultParams: defaultParams, isRoot: false, isModal: false)
    }
    
    static func routerOptionsAsRoot() -> ZKRouterOptions {
        return ZKRouterOptions.init(presentationStyle: .None, transitionStyle: .CoverVertical, defaultParams: nil, isRoot: true, isModal: false)
    }
    
    static func modalInit() -> ZKRouterOptions {
        return ZKRouterOptions.routerOptionsAsModal()
    }
    
    static func withPresentationStyle(style:UIModalPresentationStyle) -> ZKRouterOptions {
        return ZKRouterOptions.routerOptionsWithPresentationStyle(style)
    }
    
    static func withTransitionStyle(style:UIModalTransitionStyle) -> ZKRouterOptions {
        return ZKRouterOptions.routerOptionsWithTransitionStyle(style)
    }
    
    static func forDefaultParams(defaultParams:Dictionary<String,Any>?) -> ZKRouterOptions {
        return ZKRouterOptions.routerOptionsForDefaultParams(defaultParams)
    }
    
    static func root() -> ZKRouterOptions {
        return ZKRouterOptions.routerOptionsAsRoot()
    }
    
//MARK:SETTER
    func setModal() {
        self.modal = true
    }
    
    func setPresentationStyle(style:UIModalPresentationStyle) {
        self.presentationStyle = style
    }
    
    func setTransitionStyle(style:UIModalTransitionStyle) {
        self.transitionStyle = style
    }
    
    func setDefaultParams(defaultParams:Dictionary<String,Any>) {
        self.defaultParams = defaultParams
    }
    
    func setRoot() {
        self.shouldOpenAsRootViewController = true
    }
    
    
    
    
}
