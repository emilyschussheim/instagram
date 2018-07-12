//
//  User.h
//  instagram
//
//  Created by Emily Schussheim on 7/11/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import "PFUser.h"
#import "PFObject.h"
#import "Parse/Parse.h"

@interface User : PFUser<PFSubclassing>

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@end
