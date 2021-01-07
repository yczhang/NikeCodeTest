//
//  RemoteDataSource.swift
//  NikeAlbumTest
//
//  Created by YICHUN ZHANG on 1/6/21.
//

import Foundation

class RemoteRepository
{
    typealias DataCompletion = (MusicAlbum?, Bool) -> ()
    
    static func fetchData(urlStr:String, completion:@escaping DataCompletion)
    {
        let url = URL(string: urlStr)
        
        guard let value = url else {
            return
        }
        
        let request = URLRequest(url: value)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
          //execute completion handler on main thread
          DispatchQueue.main.async {
            guard error == nil else {
               SCLog.e("Failed request from MarketPlace: \(error!.localizedDescription)")
              completion(nil, false)
              return
            }
            
            guard let data = data else {
               SCLog.e("No data returned from MarketPlace")
              completion(nil, false)
              return
            }
            
            guard let response = response as? HTTPURLResponse else {
               SCLog.e("Unable to process MarketPlace response")
              completion(nil, false)
              return
            }
            
            guard response.statusCode == 200 else {
               SCLog.e("Failure response from MarketPlace: \(response.statusCode)")
              completion(nil, false)
              return
            }
           
           SCLog.d(String(decoding: data, as: UTF8.self))
            
            do {
                
                let decoder = JSONDecoder()
                
                let obj: MusicAlbum = try decoder.decode(MusicAlbum.self, from: data)

                completion(obj,true)
                
            } catch {
                SCLog.e("exception: \(error)")
                completion(nil,false)
            }
          }
        }.resume()
    }
}
