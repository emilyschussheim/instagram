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
#import "Post.h"
#import "DetailsViewController.h"

@interface TimeLineViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
- (IBAction)logoutTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onTimer) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    
    UIImage *img = [UIImage imageNamed:@"Instagram_logo.svg"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    return cell;
}
- (void) onTimer {
    
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts) {
            self.posts = posts;
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];  
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}
- (void)tableView:(UITableView *)tableView didTap:(PostCell *)postCell {
    
    [self performSegueWithIdentifier:@"detailsSegue" sender:postCell];
}

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
         if ([segue.identifier isEqualToString:@"detailsSegue"]) {
             PostCell *tappedCell = sender;
             DetailsViewController *detailsViewController = [segue destinationViewController];
             detailsViewController.post = tappedCell.post;
         }
 }

- (IBAction)logoutTapped:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
