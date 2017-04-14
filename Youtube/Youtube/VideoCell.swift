//
//  VideoCell.swift
//  Youtube
//
//  Created by Ajit Kumar Baral on 4/10/17.
//  Copyright © 2017 Ajit Kumar Baral. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    var titleLabelHeightAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            
            setupThumbnailImage()
            
            setupProfileImage()
            
            
            if let title = video?.title {
                
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 10000)
                //To get the exact width of the titleLabel text = frame.width - 16 - 44 - 8 - 16
                //16->Left margin of the profileImageView from the view
                //44->Width of the profileImageView
                //8->Left margin of the titleLabel from the profileImageView
                //16->Right margin of the titleLabel from the view
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)], context: nil)
                
                
                
                if estimatedRect.size.height > 16 {
                    titleLabelHeightAnchor?.constant = 44
                } else {
                    titleLabelHeightAnchor?.constant = 20

                }
                
                titleLabel.text = title
            }
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                subtitleTextView.text = "\(channelName) • 1 year ago • \(numberFormatter.string(from: numberOfViews)!) views"
            }
            
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageName = video?.thumbnailImageName {
            
            thumbnailImageView.loadImageUsingURLString(urlString: thumbnailImageName)
        }
        
    }
    
    func setupProfileImage() {
        
        if let profileImageName = video?.channel?.profileImageName {
            
            userProfileImageView.loadImageUsingURLString(urlString: profileImageName)
            
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "steve_youtube.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let userProfileImageView: CustomImageView = {
        
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "steve_jobs.png")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "10 Things You Didn't Know About Steve Jobs"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let subtitleTextView: UITextView = {
        
        let textView = UITextView()
        textView.text = "Top Trending • 1 year ago • 1,111,231,123,739,349 views"
        
        //Changing the default padding of the UITextView
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
        
    }()
    
    
    let separatorView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    
    override func setupViews() {
        
        
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(separatorView)
        
        //thumbnailImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        
        //Constraints for thumbnailImageView
        //x,y,width,height
        
        thumbnailImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant: -8).isActive = true
        
        
        //Constraints for userProfileImageView
        //x,y,width,height
        
        userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        userProfileImageView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -36).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //Constraints for titleLabel
        //x,y,width,height
        titleLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        titleLabelHeightAnchor = titleLabel.heightAnchor.constraint(equalToConstant: 44)
        titleLabelHeightAnchor?.isActive = true
        
        
        
        //Constraints for subtitleTextView
        //x,y,width,height
        subtitleTextView.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subtitleTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        subtitleTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
        //Constraints for separatorView
        //x,y,width,height
        separatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
    
    
}
