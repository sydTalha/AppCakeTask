//
//  RequestHandler.swift
//  AppCakeTask
//
//  Created by Rizwan on 10/8/22.
//

import Foundation
import Alamofire

let requestHandler = RequestHandler()

class RequestHandler {
    
    var sessionManager: Alamofire.Session
    var sessionToken = "mixamo2"
    
    init() {
        sessionManager = Alamofire.Session.init()
        //sessionToken = defaults.getString(key: .authToken)
    }
    
    func get(resource: String, _ parameters: Parameters? = nil, fullResource: Bool? = false) -> DataRequest {
        print(sessionToken)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsIng1dSI6Imltc19uYTEta2V5LWF0LTEuY2VyIiwia2lkIjoiaW1zX25hMS1rZXktYXQtMSIsIml0dCI6ImF0In0.eyJpZCI6IjE2NjUyMTkyNDk2MTFfZDY3NDhjNTMtMmUxNS00NTk2LTk4MDAtZGJlYzk1OTRhYzNlX3V3MiIsInR5cGUiOiJhY2Nlc3NfdG9rZW4iLCJjbGllbnRfaWQiOiJtaXhhbW8xIiwidXNlcl9pZCI6IkZEMzkzQzU4NTgyODVENTYwQTQ5NUM1N0BBZG9iZUlEIiwic3RhdGUiOiIiLCJhcyI6Imltcy1uYTEiLCJhYV9pZCI6IkZEMzkzQzU4NTgyODVENTYwQTQ5NUM1N0BBZG9iZUlEIiwiY3RwIjowLCJmZyI6IlcyNVpORVlPVlBFNUlIVUtFTVFGWUhRQVE0PT09PT09Iiwic2lkIjoiMTY2NDQ2NjAxNzQyM19iMWFlNTJmMS1jYjBlLTQyZmItYWRjMC1iNmU2ODkxZTRlMWNfdWUxIiwicnRpZCI6IjE2NjUyMTkyNDk2MTFfOGQxZmQxZTgtMDU3NC00OGE0LWJhOWUtZGM0MGY3ODVmMzk5X3V3MiIsIm1vaSI6ImM0NTQxOWZiIiwicGJhIjoiIiwicnRlYSI6IjE2NjY0Mjg4NDk2MTEiLCJleHBpcmVzX2luIjoiODY0MDAwMDAiLCJjcmVhdGVkX2F0IjoiMTY2NTIxOTI0OTYxMSIsInNjb3BlIjoib3BlbmlkLEFkb2JlSUQifQ.XjEfGlOFfdL_hhe_kdllplq3QCS8PLVXE9kiQTwamKf6ts_xyEFyLa6zROybY8HqXUkAaH4oCbFo5AEnzlpIvKogX2U4_Su4P0A_3MnHX0ZmWAelhAW1RxeBsnAnk880BRcSHvSSAFe-KR4Ps6XmUDaP_KptR76Yf02LsYnYnFh_LrvBf-J_N6v0eYtJJ8SULbwEqcPKEchJYZxBMXUn-yQqQpWBoF3FIybbVNmg5NC3DmPEis-V8zX7Id2sAlKaTBo7MG0VUD-oD85YB9_NKg18Rg-WVH7175l6zRvzgONx_WLZfllKbW_zQdBvVMHvMXdk3yNxOsieQ7HkWNTqLw",
            "X-Api-Key": "\(sessionToken)"
        ]
        #if DEBUG
        print("**** RequestHandler Get: \(Constants.baseURL + resource)")
        #endif
        if parameters == nil {
            return sessionManager.request(fullResource! ? resource : Constants.baseURL + resource,
                                          headers: headers).response { response in
                
                ResponseStatusCodeHandler.resolve(statusCode: response.response?.statusCode ?? 400)
                
                #if DEBUG
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("ReqHand Get Request: \(String(describing: response.request))")
                    print("ReqHand Get Response: \(String(describing: response.response))")
                    print("ReqHand Get Error: \(String(describing: response.error))")
                    print("RequestHandler Get Data: \(utf8Text)")
                }
                #endif
            }
        } else {
            #if DEBUG
            print("RequestHandler parameters: \(parameters!)")
            #endif
            return sessionManager.request(
                fullResource! ? resource : Constants.baseURL + resource, parameters: parameters!,
                encoding: URLEncoding(destination: .queryString),
                headers: headers).response { response in
                    
                    ResponseStatusCodeHandler.resolve(statusCode: response.response?.statusCode ?? 400)
                    
                    #if DEBUG
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("ReqHand Get Request: \(String(describing: response.request))")
                        print("ReqHand Get Response: \(String(describing: response.response))")
                        print("ReqHand Get Error: \(String(describing: response.error))")
                        print("ReqHand Get Data: \(utf8Text)")
                    }
                    #endif
            }
        }
    }
    
    
}
