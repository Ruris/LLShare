//
//  LLShare.swift
//  LLShare
//
//  Created by ZHK on 2023/8/29.
//  
//

import UIKit

public struct LLShare {
    
    /// 以指定类型的文件分享文本
    /// - Parameters:
    ///   - viewController: `Present` 分享面板的 `视图控制器`
    ///   - fileName: 文件名
    ///   - extenName: 文件扩展名
    ///   - text: 文本内容
    /// - Returns: 是否完成分享
    public static func share(_ viewController: UIViewController, fileName: String, extenName: String, text: String) async throws -> Bool {
        guard let data = text.data(using: .utf8) else {
            return false
        }
        return try await share(viewController, fileName: fileName, extenName: extenName, data: data)
    }
    
    
    
    /// 以指定类型的文件分享 Data
    /// - Parameters:
    ///   - viewController: `Present` 分享面板的 `视图控制器`
    ///   - fileName: 文件名
    ///   - extenName: 文件扩展名
    ///   - data: Data 对象
    /// - Returns: 是否完成分享
    public static func share(_ viewController: UIViewController, fileName: String, extenName: String, data: Data) async throws -> Bool {
        let path = try directory() + "\(fileName).\(extenName)"
        // 把文本写到本地
        if FileManager.default.fileExists(atPath: path) == false {
            FileManager.default.createFile(atPath: path, contents: nil)
        }
        let url = URL(fileURLWithPath: path)
        try data.write(to: url)
        // 退出时删除文件
        defer {
            try? FileManager.default.removeItem(at: url)
        }
        // 分享
        return await share(viewController, sources: [url])
    }
    
    @MainActor
    /// 分享资源到外部
    /// - Parameters:
    ///   - viewController: `Present` 分享面板的 `视图控制器`
    ///   - sources: 资源数组
    /// - Returns: 是否分享成功
    public static func share(_ viewController: UIViewController, sources: [Any]) async -> Bool {
        await withCheckedContinuation { checked in
            let activity = UIActivityViewController(activityItems: sources, applicationActivities: nil)
            activity.completionWithItemsHandler = { _, success, _, _ in
                checked.resume(with: .success(success))
            }
            viewController.present(activity, animated: true)
        }
    }
    
    /// 获取本地临时文件目录路径
    /// - Returns: 临时文件路径
    private static func directory() throws -> String {
        let path = NSTemporaryDirectory() + "LLShare/"
        // 目录不存在创建目录
        if FileManager.default.fileExists(atPath: path) == false {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
        }
        return path
    }
}
