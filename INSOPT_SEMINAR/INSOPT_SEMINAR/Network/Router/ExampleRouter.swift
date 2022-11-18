//
//  ExampleRouter.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/05.
//

import Foundation
import UIKit

import Moya

enum ExampleRouter {
    case fetchProfileV1(userID: Int)
    case fetchProfileV2(userID: Int)
    case fetchEvent(param: EventRequestDto)
    case addSong(param: AddSongRequestDto)
    case fetchSongs
}

extension ExampleRouter: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
      
        case .fetchProfileV1(userID: let userID):
            return "/user/\(userID)"
        case .fetchProfileV2(userID: _):
            return "/user"
        case .fetchEvent(param: _):
            return "/event"
        case .addSong(param: _):
            return "/music"
        case .fetchSongs:
            return "/music/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
       
        case .fetchProfileV1(userID: _):
            return .get
        case .fetchProfileV2(userID: _):
            return .get
        case .fetchEvent(param: _):
            return .get
        case .addSong(param: _):
            return .post
        case .fetchSongs:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        
        case .fetchProfileV1(userID: _):
            return .requestPlain
        case .fetchProfileV2(userID: let userID):
            let param = ["userId": userID]
            return .requestParameters(
                parameters: try! param.asParameter(),
                encoding: URLEncoding(destination: .queryString,
                                      arrayEncoding: .noBrackets)
            )
        case .fetchEvent(param: let param):
            let bodyParam = param.date
            let urlParam = ["userId": param.userId]
            return .requestCompositeParameters(
                bodyParameters: try! bodyParam.asParameter(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: try! urlParam.asParameter()
            )
            
        case .addSong(param: let param):
            var multipartFormData: [MultipartFormData] = []
            let imageData = MultipartFormData(provider: .data(param.image), name: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            multipartFormData.append(imageData)
             
            let jsonParam = ["singer": param.singer, "title": param.title] as [String: Any]
            let data = try! JSONSerialization.data(withJSONObject: jsonParam, options: .prettyPrinted)
            let jsonString = String(data: data, encoding: .utf8)!
            let stringData = MultipartFormData(provider: .data(jsonString.data(using: String.Encoding.utf8)!), name: "request", mimeType: "application/json")
            multipartFormData.append(stringData)
        
            return .uploadMultipart(multipartFormData)
            
        case .fetchSongs:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .addSong:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

