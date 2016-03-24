//
//  ViewController.swift
//  HGForceTouchDemo
//
//  Created by HamGuy on 3/24/16.
//  Copyright © 2016 HamGuy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        register3DTouchIfAviable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("testCell")
        if cell == nil{
            cell = UITableViewCell(style: .Default, reuseIdentifier: "testCell")
        }
        var cellTitle = ""
        switch indexPath.row {
        case 0:
            cellTitle = "Red"
        case 1:
            cellTitle = "Green"
        case 2:
            cellTitle = "Blue"
        case 3:
            cellTitle = "Yellow"
        default:
            break
        }
        
        cell?.textLabel?.text = cellTitle
        return cell!
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = controllerForIndexPath(indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}


extension ViewController: UIViewControllerPreviewingDelegate{
    
    private func controllerForIndexPath(indexPath:NSIndexPath)->UIViewController{
        var type = AppDelegate.ShortcutType.Blue
        switch indexPath.row {
        case 0:
            type = AppDelegate.ShortcutType.Red
        case 1:
            type = AppDelegate.ShortcutType.Green
        case 2:
            type = AppDelegate.ShortcutType.Blue
        case 3:
            type = AppDelegate.ShortcutType.Yellow
        default:
            break
        }
        let vc = TestViewController(type: type)
        return vc
    }
    
    func register3DTouchIfAviable(){
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.Available{
            self.registerForPreviewingWithDelegate(self, sourceView: self.tableView)
        }
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if self.presentedViewController is TestViewController{
            return nil
        }
        
        if let selectedIndexPath = self.tableView.indexPathForRowAtPoint(location){
            
            let vc = controllerForIndexPath(selectedIndexPath)
            if let cell = tableView.cellForRowAtIndexPath(selectedIndexPath){
                    previewingContext.sourceRect = cell.frame
            }
            return vc
        }
        return nil
        
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController){
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
}
