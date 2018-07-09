//
//  TimeLineViewController.m
//  instagram
//
//  Created by Emily Schussheim on 7/8/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import "TimeLineViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "Parse/Parse.h"

@interface TimeLineViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initImagePickerController];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initImagePickerController {

    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:imagePickerVC animated:YES completion:nil];


    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    cell.captionLabel.text = post.caption;
    cell.pictureView
    
//    ChatCellTableViewCell *chatCell = [tableView dequeueReusableCellWithIdentifier:@"ChatCellTableViewCell" forIndexPath:indexPath];
//    NSDictionary *chat = self.chats[indexPath.row];
//    NSString *text = chat[@"text"];
//    chatCell.chatLabel.text = text;
//    return chatCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
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
