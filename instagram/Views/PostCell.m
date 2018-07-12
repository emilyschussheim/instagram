//
//  PostCell.m
//  instagram
//
//  Created by Emily Schussheim on 7/9/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import "PostCell.h"
#import <UIImageView+AFNetworking.h>
#import <Parse/Parse.h>
#import <ParseUI.h>

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.propicImage.layer.cornerRadius = self.propicImage.frame.size.height / 2;
    self.propicImage.layer.masksToBounds = YES;
    self.propicImage.layer.borderWidth = 0;
    
}

-(void)setPost:(Post *)post {
    _post = post;
    self.captionLabel.text = post.caption;
    PFUser *user = self.post[@"author"];
    NSString *username = user.username;
    self.propicImage.file = user[@"profileImage"];
    [self.propicImage loadInBackground];

    self.usernameLabel.text = username;
    
    NSURL *url = [NSURL URLWithString:self.post.image.url];
    [self.pictureView setImageWithURL:url];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)likeTapped:(id)sender {
}
@end
