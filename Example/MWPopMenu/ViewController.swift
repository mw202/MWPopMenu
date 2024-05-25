//
//  ViewController.swift
//  MWPopMenu
//
//  Created by mw202 on 05/25/2024.
//  Copyright (c) 2024 mw202. All rights reserved.
//

import UIKit
import MWPopMenu

class ViewController: UIViewController, MWPopMenuDataSource, MWPopMenuDelegate {
    private lazy var popMenu: MWPopMenu = {
        var configure = MWPopMenuConfigure.default
        configure.backgroundColor = UIColor.yellow
        configure.itemConfigure.textDisabledColor = .purple
//        configure.margin = 0
//        configure.width = 100
        let menu = MWPopMenu(configure: configure)
        menu.dataSource = self
        menu.delegate = self
        return menu
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickNavigation(_ sender: UIButton) {
        var point = sender.convert(CGPoint(x: sender.frame.midX, y: sender.frame.maxY), to: nil)
        point.y = max(0, point.y)
        popMenu.show(point)
    }
    
    @IBAction func click1(_ sender: UIButton) {
        var point = sender.superview?.convert(CGPoint(x: sender.frame.midX, y: sender.frame.maxY), to: nil) ?? .zero
        point.y = max(0, point.y)
        popMenu.show(point)
    }
    
    @IBAction func click2(_ sender: UIButton) {
        var point = view.convert(CGPoint(x: sender.frame.midX, y: sender.frame.maxY), from: sender.superview)
        point.y = max(0, point.y)
        let rect = view.convert(sender.frame, from: sender.superview)
        popMenu.show(.zero, rect)
    }
    
    @IBAction func click3(_ sender: UIButton) {
        var point = view.convert(CGPoint(x: sender.frame.midX, y: sender.frame.maxY), from: sender.superview)
        point.y = max(0, point.y)
        let rect = view.convert(sender.frame, from: sender.superview)
        popMenu.show(.zero, rect)
    }
    
    @IBAction func click4(_ sender: UIButton) {
        var point = view.convert(CGPoint(x: sender.frame.midX, y: sender.frame.maxY), from: sender.superview)
        point.y = max(0, point.y)
        let rect = view.convert(sender.frame, from: sender.superview)
        popMenu.show(.zero, rect)
    }
    
    @IBAction func click5(_ sender: UIButton) {
        var point = view.convert(CGPoint(x: sender.frame.midX, y: sender.frame.maxY), from: sender.superview)
        point.y = max(0, point.y)
        let rect = view.convert(sender.frame, from: sender.superview)
        popMenu.show(.zero, rect)
    }
    
    @IBAction func clickL(_ sender: UIButton) {
        var point = view.convert(CGPoint(x: sender.frame.midX, y: sender.frame.maxY), from: sender.superview)
        point.y = max(0, point.y)
        let rect = view.convert(sender.frame, from: sender.superview)
        popMenu.show(.zero, rect)
    }
    
    @IBAction func clickR(_ sender: UIButton) {
        var point = view.convert(CGPoint(x: sender.frame.midX, y: sender.frame.maxY), from: sender.superview)
        point.y = max(0, point.y)
        let rect = view.convert(sender.frame, from: sender.superview)
        popMenu.show(.zero, rect)
    }
    
    // MARK: - MWPopMenu data source
    
    func mwMenuDatas(_ menu: MWPopMenu) -> [MWPopMenuModel]? {
        return [MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "新增"),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "扫描", isEnabled: false),]
        return [MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "新增"),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "扫描", isEnabled: false),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "新增"),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "扫描", isEnabled: false),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "新增"),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "扫描", isEnabled: false),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "新增"),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "扫描", isEnabled: false),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "新增"),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "扫描", isEnabled: false),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "新增"),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "扫描", isEnabled: false),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "新增"),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "扫描", isEnabled: false),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "新增"),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "扫描", isEnabled: false),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "新增"),
                MWPopMenuModel(icon: #imageLiteral(resourceName: "address_book_number"), title: "扫描", isEnabled: false),]
    }
    
    // MARK: - MWPopMenu delegate
    
    func mwPopMenuDidSelectIndex(_ view: MWPopMenu, index: Int) {
        //
    }
}

