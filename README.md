# MWPopMenu

[![CI Status](https://img.shields.io/travis/mw202/MWPopMenu.svg?style=flat)](https://travis-ci.org/mw202/MWPopMenu)
[![Version](https://img.shields.io/cocoapods/v/MWPopMenu.svg?style=flat)](https://cocoapods.org/pods/MWPopMenu)
[![License](https://img.shields.io/cocoapods/l/MWPopMenu.svg?style=flat)](https://cocoapods.org/pods/MWPopMenu)
[![Platform](https://img.shields.io/cocoapods/p/MWPopMenu.svg?style=flat)](https://cocoapods.org/pods/MWPopMenu)

## 说明

Swift弹出式菜单，[在此](https://www.jianshu.com/p/9d0f50f4a50a)基础上进行优化。

![截图1](/docs/screenshot1.png)

## 安装

MWPopMenu is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MWPopMenu'
```

## 使用

* 使用dataSource设置数据

  ```Swift
  func mwMenuDatas(_ menu: MWPopMenu) -> [MWPopMenuModel]?
  ```
* 使用delegate或block处理点击事件

  ```Swift
  func mwPopMenuDidSelectIndex(_ view: MWPopMenu, index: Int)
  ```

## Author

mw202, 250230331@qq.com

## License

MWPopMenu is available under the MIT license. See the LICENSE file for more info.
