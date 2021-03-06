//
//  Post.h
//  instagram
//
//  Created by Emily Schussheim on 7/9/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import "PFObject.h"
#import "Parse/Parse.h"

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFile *image;
@property (nonatomic, strong) NSString *likesCount;
@property (nonatomic, strong) NSNumber *commentCount;
@property (nonatomic, strong) NSDate *createdAt;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image;

@end
