//
//  NewPostViewController.m
//  instagram
//
//  Created by Emily Schussheim on 7/9/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import "NewPostViewController.h"
#import "Post.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "ImagePickerController.h"

@interface NewPostViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate> 
- (IBAction)addPhotoTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *captionTextField;
@property (strong, nonatomic) UIImage *image;
@property CGSize size;
- (IBAction)postTapped:(id)sender;

@end

@implementation NewPostViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = 200;
    CGFloat height = 200;
    self.size = CGSizeMake(width, height);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    //UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"IMAGE WAS PICKED");
    UIImage *newImage = [ImagePickerController resizeImage:originalImage withSize:self.size];
    self.image = newImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addPhotoTapped:(id)sender {
    UIImagePickerController *imagePickerVC = [ImagePickerController createImagePickerControllerwith:self];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (IBAction)postTapped:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Post postUserImage:self.image withCaption:self.captionTextField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
        NSLog(@"image sent to parse!");
            self.captionTextField.text = @"";
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSegueWithIdentifier:@"afterPostSegue" sender:(sender)];
        } else {
            NSLog(@"image failed to go to parse");
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
@end
