//
//  MWPopMenu.swift
//  calculator_tools
//
//  Created by LiYing on 2024/5/23.
//  Copyright © 2024 Nnwise. All rights reserved.
//

import UIKit

public protocol MWPopMenuDataSource: NSObjectProtocol {
    func mwMenuDatas(_ menu: MWPopMenu) -> [MWPopMenuModel]?
}

public protocol MWPopMenuDelegate: NSObjectProtocol {
    func mwPopMenuDidSelectIndex(_ view: MWPopMenu, index: Int)
}

// MARK: - MWPopMenu

public class MWPopMenu: UIView {

    public weak var dataSource: MWPopMenuDataSource?
    public weak var delegate: MWPopMenuDelegate?
    
    public var didSelectMenuBlock: ((_ view: MWPopMenu, _ index: Int) -> Void)?
    
    let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
    let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height
    
    private var menuConfigure: MWPopMenuConfigure = MWPopMenuConfigure.default
    
    private var targetRect: CGRect?
    private var arrowPoint: CGPoint = .zero
    private let arrowWidth: CGFloat = 15
    private let arrowHeight: CGFloat = 10
    
    private var datas: [MWPopMenuModel] = []
    
    let cellId = String(describing: MWPopMenuItemTableViewCell.self)
    private var tableFrame: CGRect = .zero
    private var arrowView: UIView!
    var tableView: UITableView!
    
    public init(configure: MWPopMenuConfigure = MWPopMenuConfigure.default) {
        super.init(frame: UIScreen.main.bounds)
        
        menuConfigure = configure
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(menuConfigure.alpha)
        
        var p = getArrowPoints()
        tableFrame.origin = p.tableOriginal
        let isArrowUp = p.isArrowUp
        
        arrowView = UIView(frame: CGRect(x: tableFrame.origin.x, y: isArrowUp ? (tableFrame.origin.y - arrowHeight) : tableFrame.maxY, width: tableFrame.width, height: arrowHeight))
        
        // 微调，箭头太靠边时，会与tableView错位
        var offsetX: CGFloat = 0
        if p.arrow.left.x < menuConfigure.cornorRadius {
            offsetX = menuConfigure.cornorRadius - p.arrow.left.x
        }
        if p.arrow.right.x > (tableFrame.width - menuConfigure.cornorRadius) {
            offsetX = -(p.arrow.right.x - tableFrame.width + menuConfigure.cornorRadius)
        }
        p.arrow.left.x += offsetX
        p.arrow.right.x += offsetX
        
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: p.arrow.top)
        path.addLine(to: p.arrow.left)
        path.addLine(to: p.arrow.right)
        layer.path = path.cgPath
        layer.fillColor = menuConfigure.backgroundColor.cgColor
        arrowView.layer.addSublayer(layer)
        addSubview(arrowView)
        
        tableView = UITableView(frame: tableFrame, style: .plain)
        // tableView超出刘海时，会空出一截
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }

        var bundle = Bundle.main
        if let url = Bundle(for: Self.self).url(forResource: "MWPopMenu", withExtension: "bundle") {
            bundle = Bundle(url: url) ?? Bundle.main
        }
        tableView.register(UINib(nibName: cellId, bundle: bundle), forCellReuseIdentifier: cellId)
        tableView.backgroundColor = menuConfigure.backgroundColor
        tableView.layer.cornerRadius = menuConfigure.cornorRadius
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        UIView.animate(withDuration: 0.3) {
            self.addSubview(self.tableView)
        }
    }
    
    /// 顶、左、右、tableView原点、是否箭头朝上
    private func getArrowPoints() -> (arrow: (top: CGPoint, left: CGPoint, right: CGPoint),
                                      tableOriginal: CGPoint,
                                      isArrowUp: Bool) {
        var safeArea: UIEdgeInsets?
        if #available(iOS 11.0, *) {
            safeArea = UIApplication.shared.windows.last?.safeAreaInsets
        } else {
            // Fallback on earlier versions
            let viewController = UIApplication.shared.windows.last?.rootViewController
            safeArea = UIEdgeInsets(top: viewController?.topLayoutGuide.length ?? 0, left: 0, bottom: viewController?.bottomLayoutGuide.length ?? 0, right: 0)
        }
        let safeAreaTop = safeArea?.top ?? 0
        let safeAreaBottom = safeArea?.bottom ?? 0
        
        var bUp = false //
        if let r = targetRect {
            arrowPoint.x = r.midX
            bUp = (kScreenHeight - r.maxY) > (tableFrame.height + arrowHeight)
            arrowPoint.y = bUp ? r.maxY : r.minY
        } else {
            bUp = (kScreenHeight - arrowPoint.y) > tableFrame.height
        }
        
        arrowPoint.x = max(menuConfigure.margin, min(arrowPoint.x, kScreenWidth - menuConfigure.margin))
        // 不能超过安全区
        tableFrame.size.height = bUp ? min(kScreenHeight - arrowPoint.y - arrowHeight - safeAreaBottom, tableFrame.height) : min(arrowPoint.y - arrowHeight - safeAreaTop, tableFrame.height)
        
        var originalPoint = CGPoint.zero
        var arrowMargin: CGFloat = menuConfigure.margin
        if arrowPoint.x < kScreenWidth / 2 { // 点击点在屏幕左边，tableView在屏幕左边
            if arrowPoint.x > tableFrame.width / 2 {
                arrowMargin = tableFrame.width / 2
                originalPoint = CGPoint(x: arrowPoint.x - tableFrame.width / 2, y: arrowPoint.y + arrowHeight)
            } else { // tableView和箭头不在垂直线上
                arrowMargin = arrowPoint.x - menuConfigure.margin
                originalPoint = CGPoint(x: menuConfigure.margin, y: arrowPoint.y + arrowHeight)
            }
        } else {
            if (kScreenWidth - arrowPoint.x) < tableFrame.width / 2 { // tableView和箭头不在垂直线上
                arrowMargin = tableFrame.width - (kScreenWidth - arrowPoint.x) + menuConfigure.margin
                originalPoint = CGPoint(x: kScreenWidth - menuConfigure.margin - tableFrame.width, y: arrowPoint.y + arrowHeight)
            } else {
                arrowMargin = tableFrame.width / 2
                originalPoint = CGPoint(x: arrowPoint.x - tableFrame.width / 2, y: arrowPoint.y + arrowHeight)
            }
        }
        
        if bUp {
            return (arrow: (top: CGPoint(x: arrowMargin, y: 0),
                            left: CGPoint(x: arrowMargin - arrowWidth / 2, y: arrowHeight),
                            right: CGPoint(x: arrowMargin + arrowWidth / 2, y: arrowHeight)),
                    tableOriginal: originalPoint,
                    isArrowUp: true)
        } else {
            originalPoint.y = arrowPoint.y - tableFrame.height - arrowHeight
            return (arrow: (top: CGPoint(x: arrowMargin, y: arrowHeight),
                            left: CGPoint(x: arrowMargin - arrowWidth / 2, y: 0),
                            right: CGPoint(x: arrowMargin + arrowWidth / 2, y: 0)),
                    tableOriginal: originalPoint,
                    isArrowUp: false)
        }
    }
    
    /// 显示菜单
    /// - Parameters:
    ///   - point: 点击的点CGPoint，需要转换成全屏幕的坐标
    ///   - rect: 点击的区域CGRect，通常为控件的frame，需要转换成全屏幕的区域
    /// - Note:
    ///   - 如果设置了rect，会忽略point。将自动判断在控件的上部还是下部显示菜单
    /// - Important:
    ///   - navigationBar.isTranslucent = false 的情况下view不能顶到头，因此rect参数最好使用window来计算
    /// ```
    /// let window = UIApplication.shared.keyWindow
    /// let rect = window?.convert(_:from:)
    /// ```
    public func show(_ point: CGPoint = .zero, _ rect: CGRect? = nil) {
        self.datas = dataSource?.mwMenuDatas(self) ?? []
        if datas.isEmpty {
            return
        }
        
        targetRect = rect
        arrowPoint = point
            
        tableFrame = CGRect(x: 0, y: 0, width: menuConfigure.width, height: menuConfigure.itemHeight * CGFloat(datas.count))
        tableFrame.size.height = min(kScreenHeight / 2, tableFrame.height)
        tableFrame.size.width = min(kScreenWidth - menuConfigure.margin * 2, tableFrame.width)
        
        setupUI()
        
        UIApplication.shared.windows.last?.addSubview(self)
    }
    
    public func dismiss() {
        arrowView.removeFromSuperview()
        tableView.removeFromSuperview()
        removeFromSuperview()
    }
}

// MARK: - Table view data source

extension MWPopMenu: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MWPopMenuItemTableViewCell {
            let item = datas[indexPath.row]
            cell.setCell(item, configure: menuConfigure, isLast: (indexPath.row == datas.count - 1))
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - Table view delegate

extension MWPopMenu: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return menuConfigure.itemHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = datas[indexPath.row]
        if item.isEnabled == false { return }
        
        delegate?.mwPopMenuDidSelectIndex(self, index: indexPath.row)
        didSelectMenuBlock?(self, indexPath.row)
        
        dismiss()
    }
}

// MARK: -

extension MWPopMenu {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != tableView {
            dismiss()
        }
    }
}
