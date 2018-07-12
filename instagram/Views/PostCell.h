//
//  PostCell.h
//  instagram
//
//  Created by Emily Schussheim on 7/9/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <ParseUI.h>

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *propicImage;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
- (IBAction)likeTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) Post *post;
@end
