# LLShare

[![CI Status](https://img.shields.io/travis/Ruris/LLShare.svg?style=flat)](https://travis-ci.org/Ruris/LLShare)
[![Version](https://img.shields.io/cocoapods/v/LLShare.svg?style=flat)](https://cocoapods.org/pods/LLShare)
[![License](https://img.shields.io/cocoapods/l/LLShare.svg?style=flat)](https://cocoapods.org/pods/LLShare)
[![Platform](https://img.shields.io/cocoapods/p/LLShare.svg?style=flat)](https://cocoapods.org/pods/LLShare)

## Example

方便导入本地文件, 对 `UIActivityViewController` 进行了简单的异步封装.

```swift
Task {
    do {
        let success = try await LLShare.share(self, fileName: "abc", extenName: "txt", text: "666")
        print(success)
    } catch {
        print(error)
    }
}
```

## Requirements

## Installation

LLShare is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LLShare', '~> 0.1.0'
```

## Author

Ruris, ruris@foxmail.com

## License

LLShare is available under the MIT license. See the LICENSE file for more info.
