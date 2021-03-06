//
//  CinemaNetwork.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 31/07/2021.
//

import Foundation
import UIKit
import Alamofire

class CinemaNetwork {
    class func cinemaRequest<ResponseType: Decodable>(
        _ endpoint: (String,ResponseType.Type),
        _ viewController: UIViewController = UIViewController(),
        _ params: Parameters = [:],
        _ method: HTTPMethod = .get,
        _ showError: Bool = true,
        _ paramEndcoding: CinemaNetworkConfig.RequestEncoding = .url,
        files: [String: (Data, String)]? = nil,
        isMultipart: Bool = false,
        completionHandler: @escaping (ResponseType?,String?) -> Void) {
        
        alamoRequest(
            url: NConstants.endpoint(endpoint.0),
            params,
            method: method,
            responseType: endpoint.1,
            paramEncoding: paramEndcoding,
            viewController: viewController,
            showError: showError,
            files: files,
            isMultipart: isMultipart
        ) { (response, errorMessage, error) in
            if errorMessage.isEmpty == false {
                completionHandler(nil,errorMessage)
            } else {
                completionHandler(response,nil)
            }
            
        }
    }
    
    class func alamoRequest<ResponseType: Decodable>(
        url: URL,
        _ params: Parameters,
        method: HTTPMethod = .get,
        responseType: ResponseType.Type,
        paramEncoding: CinemaNetworkConfig.RequestEncoding = .url,
        viewController: UIViewController = UIViewController(),
        showError: Bool = true,
        files: [String: (Data, String)]? = nil,
        isMultipart: Bool = false,
        completion: @escaping (ResponseType?,String, Error?) -> Void) {
        
        var req: DataRequest?
        var manager: Session
        if isMultipart {
            (req, manager) = multipartUpload(url: url, params, files: files)
        } else {
            (req, manager) = request(url: url, params, method: method, responseType: responseType, headers: CinemaNetworkConfig.getHeaders(), paramEncoding: paramEncoding)
        }
                
        req!
            .validate(statusCode: 200...300)
            .responseJSON { response in
                handleResponse(response,viewController,showError, url: url, completion: completion)
                manager.session.invalidateAndCancel()
            }
        
        }
    
    class func request<ResponseType: Decodable>(
        url: URL,
        _ params: Parameters,
        method: HTTPMethod = .get,
        responseType: ResponseType.Type,
        headers: HTTPHeaders = CinemaNetworkConfig.getHeaders(),
        paramEncoding: CinemaNetworkConfig.RequestEncoding = .url
    ) -> (DataRequest, Session) {
        let manager = Alamofire.Session(configuration: .default)
        var parameters = params
        parameters["api_key"] = apiKey
        let request = manager.request(
            url,
            method: method,
            parameters: parameters,
            encoding: (paramEncoding == .url) ? URLEncoding.queryString : JSONEncoding.default,
            headers: CinemaNetworkConfig.getHeaders()
        )
        return (request, manager)
    }
    
    class func multipartUpload(
        url: URL,
        _ params: [String: Any],
        files: [String: (Data, String)]?
    ) -> (DataRequest, Session) {
        let headers = CinemaNetworkConfig.getHeaders()
        
        let manager = Alamofire.Session(configuration: .default)
        let request = manager.upload(
            multipartFormData: { multiPartData in
                for (key, value) in params {
                    multiPartData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                if let files = files {
                    for (fileName, (file, mimeType)) in files {
                        multiPartData.append(file, withName: fileName, fileName: fileName, mimeType: mimeType)
                    }
                }
            },
            to: url,
            method: .post,
            headers: headers
        )
        return (request, manager)
    }
    
    class func handleResponse<ResponseType: Decodable>(
        _ response: AFDataResponse<Any>,
        _ viewController: UIViewController = UIViewController(),
        _ showError: Bool = true,
        url: URL,
        completion: @escaping (ResponseType?,String, Error?) -> Void
    ) {
        switch response.result {
        case .success:
            do {
                let responseObject = try JSONDecoder().decode(ResponseType.self, from: response.data!)
                DispatchQueue.main.async {
                    completion(responseObject,"",nil)
                }
            } catch {
                if showError {
                    Alerter.showAlert(message: error.localizedDescription, controller: viewController)
                }
                print(error.localizedDescription)
                completion(nil,"",error)
                
            }
        case .failure(let error):
            do {
                let responseObject = try JSONDecoder().decode(ErrorResponse.self, from: response.data!)
                if showError {
                    Alerter.showAlert(message: responseObject.status_message ?? "", controller: viewController)
                }
                DispatchQueue.main.async {
                    completion(nil,responseObject.status_message ?? "",error)
                }
            } catch {
                if showError {
                    Alerter.showAlert(message: error.localizedDescription, controller: viewController)
                }
                print(error.localizedDescription)
                completion(nil,"",error)
            }
        }
    }
}
