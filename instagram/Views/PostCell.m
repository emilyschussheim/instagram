//
//  PostCell.m
//  instagram
//
//  Created by Emily Schussheim on 7/9/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setPost:(Post *)post {
    _post = post;
    self.captionLabel.text = post.caption;
    NSData *data = [post.image getData];
    self.usernameLabel.text = self.post.author.username;
    self.imageView.image = [UIImage imageWithData:data];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)likeTapped:(id)sender {
}
@end
