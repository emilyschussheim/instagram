//
//  ProfileViewController.m
//  instagram
//
//  Created by Emily Schussheim on 7/10/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "PostCell.h"
#import "Post.h"
#import "ImagePickerController.h"
#import "User.h"

@interface ProfileViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)setProfileTapped:(id)sender;
@property (strong, nonatomic) UIImage *image;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *posts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) onTimer {
    
    PFUser *user = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"author" equalTo:user];
    [query includeKey:@"author"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    //UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"IMAGE WAS PICKED");
    
    CGFloat width = 200;
    CGFloat height = 200;
    CGSize size = CGSizeMake(width, height);

    
    UIImage *newImage = [ImagePickerController resizeImage:originalImage withSize:size];
    self.image = newImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setProfileTapped:(id)sender {
    UIImagePickerController *imagePickerVC = [ImagePickerController createImagePickerControllerwith:self];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
@end
