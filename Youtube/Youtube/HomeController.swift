//
//  ViewController.swift
//  Youtube
//
//  Created by Ajit Kumar Baral on 4/10/17.
//  Copyright © 2017 Ajit Kumar Baral. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    var videos: [Video] = {
//        
//        var topTrendingChannel = Channel()
//        topTrendingChannel.name = "Top Trending"
//        topTrendingChannel.imageProfileName = "steve_jobs"
//        
//        var markRonsonVEVOChannel = Channel()
//        markRonsonVEVOChannel.name = "MarkRonsonVEVO"
//        markRonsonVEVOChannel.imageProfileName = "mark_ronson_video"
//        
//        var steveJobsVideo = Video()
//        steveJobsVideo.thumbnailImageName = "steve_youtube"
//        steveJobsVideo.title = "10 Things You Didn't Know About Steve Jobs"
//        steveJobsVideo.numberOfViews = 1438482339248
//        
//        steveJobsVideo.channel = topTrendingChannel
//        
//        var markRonsonVideo = Video()
//        markRonsonVideo.thumbnailImageName = "updown_funk_youtube"
//        markRonsonVideo.title = "Mark Ronson - Uptown Funk ft. Bruno Mars"
//        markRonsonVideo.numberOfViews = 44928474849
//        markRonsonVideo.channel = markRonsonVEVOChannel
//        
//        return [steveJobsVideo, markRonsonVideo]
//    }()
    
    var videos: [Video]?
    
    private let cellId = "cellId"
    
    func fetchVideos() {
        
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                print(json)
                
                self.videos = [Video]()
                
                //dictionary is the array of dictionary object
                for dictionary in json as! [[String:Any]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    
                    let channelDictionary = dictionary["channel"] as! [String:Any]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    
                    self.videos?.append(video)
                }
                
                DispatchQueue.main.async {
                    
                    self.collectionView?.reloadData()
                }
                
                
            }catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    //Views
    
    let menuBar: MenuBar = {
        
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        //Set the navigation bar to be opaque
        navigationController?.navigationBar.isTranslucent = false
        
        //Set the navigation title
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        
        setupMenuBar()
        setupNavBarButtons()
        
        fetchVideos()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //height = (width of the frame - left padding of the thumbnailImageView - right padding of the thumbnailImageView) dividing the aspect ratio of the image i.e 1.7777777778 which is 16/9 or 1280/720
        
        let height = (view.frame.width - 16 - 16) / (16/9)
        
        let requiredHeight = height + 16+8+44+36
        //height->height of the thumbnailImageView
        //16->margin from the top of the cell to the thumbnailImageView
        //8->margin from the profileImageView to thumbnailImageView
        //44->height of the profileImageView
        //36->margin from the profileImageView to the separatorView
        //requiredHeight->Total height of the cell
        
        return CGSize(width: view.frame.width, height: requiredHeight)
    }
    
    
    //Removing the default spacing spacified by the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    private func setupMenuBar() {
    
        
        view.addSubview(menuBar)
        
        menuBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    private func setupNavBarButtons() {
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreButton, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    
    func handleSearch() {
        print(123)
    }
    
    func handleMore() {
        print(456)
    }
    
}




