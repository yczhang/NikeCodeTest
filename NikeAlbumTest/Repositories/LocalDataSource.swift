//
//  LocalDataSource.swift
//  NikeAlbumTest
//
//  Created by YICHUN ZHANG on 1/6/21.
//

import Foundation

class LocalRepository
{
    typealias DataCompletion = (MusicAlbum?, Bool) -> ()
    
    static func fetchData(path:String, completion:@escaping DataCompletion)
    {
        let bundle = Bundle(for: Self.self)
    
        if let filepath = bundle.path(forResource: path, ofType: "json")
        {
            let decoder = JSONDecoder()
            do {
                let contents = try String(contentsOfFile: filepath)
            
                let data = try decoder.decode(MusicAlbum.self, from: contents.data(using: .utf8)!)

                completion(data,true)
                
            } catch {
                SCLog.e("exception: \(error)")
                completion(nil,false)
            }
        }else{
        SCLog.e("resource is not available")
        completion(nil,false)
            
        }
    }
}
