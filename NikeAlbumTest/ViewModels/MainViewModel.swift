//
//  MainViewModel.swift
//  NikeAlbumTest
//
//  Created by YICHUN ZHANG on 1/6/21.
//

import UIKit

class MainViewModel: NSObject {
    
    var album: MusicAlbum?
    
    var isDataReady = ValueBox(false)
    
    func getAlbumCount() -> Int
    {
        return album?.feed?.results?.count ?? 0
    }

    func getName(index:Int)->String?
    {
        return album?.feed?.results?[index].name
    }
    
    func getArtist(index: Int)->String?
    {
        return album?.feed?.results?[index].artistName
    }
    
    func getIconUrl(index :Int) -> String?
    {
        return album?.feed?.results?[index].iconurl
    }
    
    func getItem(index : Int) -> MusicItem?
    {
        return album?.feed?.results?[index]
    }
    
    func loadLocalData(){
        LocalRepository.fetchData(path: "demo", completion: { data,flag in
            
            if flag {
                self.album = data
                self.isDataReady.value = true
            }
            
        })
    }
    
    func loadRemoteData(){
        RemoteRepository.fetchData(urlStr: Configuration.service_uuid_str, completion: { data,flag in
            if flag {
            self.album = data
            self.isDataReady.value = true
            }
        })
    }
}
