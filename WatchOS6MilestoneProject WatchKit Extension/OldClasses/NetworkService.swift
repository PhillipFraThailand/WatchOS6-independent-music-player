//
//  NetworkService.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 9/11/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//
/*
//MARK: - Protocol
protocol TrackProviderProtocol {
    func getData() -> [String]?
    func queryForPuplicPlaylists() -> Void
}
// MARK:- Class
import Foundation
class MockNetworkService : TrackProviderProtocol {
    
//MARK:- Singleton
    static let sharedInstance = MockNetworkService()
    private init (){
        print("MockNS born")
    }
    
//MARK:-  Properties
    var listOfRessources: [String]?
    var dataTask: URLSessionDataTask?
    let session = URLSession(configuration: .default)
    let url = URL(string:"http://graphql-musiclab.azurewebsites.net/graphql")
    let postString = "{\"operationName\":null,\"variables\":{},\"query\":\"{\n publicPlaylists {\nplaylists {\n title\n tracks: tracks(take: 2, skip: 0) {\n title\n url\n}\n}\n}\n}\n\"}"
    
//MARK:- Functions
    func queryForPuplicPlaylists() {
        dataTask?.cancel()
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: .utf8)
       
       let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                    
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        //print("data: \(dataString)")
                        do {
                            let decoder = JSONDecoder()
                            let jsonResponse = try decoder.decode(JSONResponse.self, from: data)
                        } catch {
                            print("JSON error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        task.resume()
        //localJsonString()
    }

//MARK:- Local JSON parsing for testing

        func localJsonString() {
            //Theres ONE key:value in the top level element and thats the users dictionary which contains a list,[], of objects ,{}, which contains key:value pairs aswell.
            let jsonString = """
            {
                "users":
                [
                    {
                        "first_name": "Arthur",
                        "last_name": "Dent"
                    }, {
                        "first_name": "Zaphod",
                        "last_name": "Beeblebrox"
                    }, {
                        "first_name": "Marvin",
                        "last_name": "The Paranoid Android"
                    }
                ]
            }
            """
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                let response = try! decoder.decode(LocalResponse.self, from: jsonData)
                for user in response.users {
                    print(user.first_name)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getData() -> [String]? {
        listOfRessources = ["http://yousee.catalog.api.247e.com/tracks/125859326", "http://samples.cdn.247e.com/xmlserver/samples/14342000-14342999/721cf187-1946-47cf-b25e-7dec5b4e9764.mp3", "http://samples.cdn.247e.com/xmlserver/samples/7206000-7206999/dbbffe79-01b2-4ffe-a89a-b3758a273d82.mp3"]
        return listOfRessources!
        
    }
}
/*//MARK: - Local file JSON Decoder unused
func load<T: Decodable>(_ filename:String, as type:T.Type = T.self) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: "JSON", withExtension: nil)
        else {
            fatalError("Could not find \(filename) in main bundle")
        }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not find \(filename) from main bundle: \n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Could not parse \(filename) as \(T.self):\n\(error)")
    }
}
*/
*/
