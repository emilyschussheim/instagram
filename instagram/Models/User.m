//
//  User.m
//  instagram
//
//  Created by Emily Schussheim on 7/11/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic url;
@dynamic username;
@dynamic password;


+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    User *newUser = [User new];
    newUser.username = [PFUser currentUser][@"username"];
    
    [newUser saveInBackgroundWithBlock: completion];
}

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
