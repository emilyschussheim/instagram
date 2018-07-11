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
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    //UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"IMAGE WAS PICKED");
    //UIImage *newImage = [self resizeImage:originalImage withSize:self.size];
    self.image = originalImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) createImagePickerController {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

- (IBAction)addPhotoTapped:(id)sender {
    [self createImagePickerController];
}
- (IBAction)postTapped:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [Post postUserImage:self.image withCaption:self.captionTextField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
        NSLog(@"image sent to parse!");
            self.captionTextField.text = @"";
             [MBProgressHUD showHUDAddedTo:self.view animated:NO];
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
