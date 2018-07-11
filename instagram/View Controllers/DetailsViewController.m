//
//  DetailsViewController.m
//  instagram
//
//  Created by Emily Schussheim on 7/9/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import "DetailsViewController.h"
#import "NSDate+TimeAgo.h"
#import "DateTools.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
   
}
- (void)setUI {
    self.captionLabel.text = self.post.caption;
    NSData *data = [self.post.image getData];
    self.pictureView.image = [UIImage imageWithData:data];
    
    self.usernameLabel.text = self.post.author.username;
    
    
    NSDate *postDate = self.post.createdAt;
    NSString *date = [postDate timeAgo];
    self.timeStampLabel.text = date;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
