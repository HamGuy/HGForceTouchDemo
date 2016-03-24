//
//  TestViewController.swift
//  HGForceTouchDemo
//
//  Created by HamGuy on 3/24/16.
//  Copyright © 2016 HamGuy. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    private var vcType:AppDelegate.ShortcutType!
    
    convenience init(type:AppDelegate.ShortcutType){
        self.init()
        self.vcType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var bgColor = UIColor.whiteColor()
        
        switch self.vcType! {
        case AppDelegate.ShortcutType.Red:
            bgColor = UIColor.redColor()
        case AppDelegate.ShortcutType.Blue:
            bgColor = UIColor.blueColor()
        case AppDelegate.ShortcutType.Green:
            bgColor = UIColor.greenColor()
        case AppDelegate.ShortcutType.Yellow:
            bgColor = UIColor.yellowColor()
        }
        
        self.title = self.vcType.rawValue
        self.view.backgroundColor = bgColor
    }


    override func previewActionItems() -> [UIPreviewActionItem] {
        let peekAction1 = UIPreviewAction(title: "Action 1", style: UIPreviewActionStyle.Default) { (action, controller) in
            NSLog(action.title)
        }
        
        let peekAction2 = UIPreviewAction(title: "Action 2", style: UIPreviewActionStyle.Selected) { (action, controller) in
            NSLog(action.title)
        }
        
        let peekAction3 = UIPreviewAction(title: "Action 3", style: UIPreviewActionStyle.Default) { (action, controller) in
            NSLog(action.title)
        }
        let peekAction4 = UIPreviewAction(title: "Tap 1", style: .Destructive) { (action, controller) in
            NSLog(action.title)
        }
        let peekAction5 = UIPreviewAction(title: "Tap 2", style: UIPreviewActionStyle.Default) { (action, controller) in
            NSLog(action.title)
        }
        let peekAction6 = UIPreviewAction(title: "Tap 3", style: .Default) { (action, controller) in
            NSLog(action.title)
        }
        
        let peekAction7 = UIPreviewAction(title: "Tap 4", style: .Destructive) { (action, controller) in
            NSLog(action.title)
        }
        
        let actions = [peekAction1,peekAction2,peekAction3]
        let taps = [peekAction4,peekAction5,peekAction6,peekAction7]
        
        let actionGroup = UIPreviewActionGroup(title: "Actions", style: .Default, actions: actions)
        let tapGroup = UIPreviewActionGroup(title: "Taps", style: .Default, actions: taps)
        
        return [actionGroup,tapGroup]
    }
}
