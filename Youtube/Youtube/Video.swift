//
//  Video.swift
//  Youtube
//
//  Created by Ajit Kumar Baral on 4/14/17.
//  Copyright © 2017 Ajit Kumar Baral. All rights reserved.
//

import UIKit

class Video: NSObject{

    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: Date?
    var channel: Channel?
}


class Channel: NSObject {
    
    var name: String?
    var profileImageName: String?
}
