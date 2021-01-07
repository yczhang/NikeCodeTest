//
//  DetailViewModel.swift
//  NikeAlbumTest
//
//  Created by YICHUN ZHANG on 1/6/21.
//

import Foundation

class DetailViewModel : NSObject
{
    var item : MusicItem?
    
    func getName()->String?
    {
        return item?.name
    }
    
    func getArtist()->String?
    {
        return item?.artistName
    }
    
    func getIconUrl()->String?
    {
        return item?.iconurl
    }
    
    func getITuneUrl()->String?
    {
        return item?.url
    }
}
