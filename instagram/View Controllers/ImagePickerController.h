//
//  ImagePickerController.h
//  instagram
//
//  Created by Emily Schussheim on 7/10/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerController : UIViewController

+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;

+ (UIImagePickerController *)createImagePickerControllerwith:(id)viewController;



@end
