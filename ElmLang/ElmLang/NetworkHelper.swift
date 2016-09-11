//
//  NetworkHelper.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/14.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class NetworkHelper: NSObject {

    let baseURL = "http://private-6adc49-elmapp.apiary-mock.com"

    func fetchURLLocations(callback: @escaping (Data?, Error?) -> Void) {

        // 获取Url
        let url = URL(string: "\(baseURL)/locations")!
        // 转换为requset
        let request = URLRequest(url: url)
        //NSURLSession 对象都由一个 NSURLSessionConfiguration 对象来进行初始化，后者指定了刚才提到的那些策略以及一些用来增强移动设备上性能的新选项
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)

        //NSURLSessionTask负责处理数据的加载以及文件和数据在客户端与服务端之间的上传和下载，NSURLSessionTask 与 NSURLConnection 最大的相似之处在于它也负责数据的加载，最大的不同之处在于所有的 task 共享其创造者 NSURLSession 这一公共委托者（common delegate）
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            if error != nil {
                callback(nil, error)
            } else {
                callback(data, nil)
            }
        }

        // 启动任务
        task.resume()
    }

    func fetchAppConfigs(callback: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: "\(baseURL)/configs")!
        let request = URLRequest(url: url)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)

        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            if error != nil {
                callback(nil, error)
            } else {
                callback(data, nil)
            }
        }

        task.resume()
    }

    func fetchJavascripts(callback: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: "\(baseURL)/scripts")!
        let request = URLRequest(url: url)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)

        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            if error != nil {
                callback(nil, error)
            } else {
                callback(data, nil)
            }
        }

        task.resume()
    }
}
