//
//  SignInViewController.m
//  instagram
//
//  Created by Emily Schussheim on 7/8/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import "SignInViewController.h"
#import "Parse/Parse.h"
#import "User.h"

@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
- (IBAction)signupButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)loginButtonTapped:(id)sender;


@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)registerUser {
    // initialize a user object
    User *newUser = [User new];
    
    // set user properties
    newUser.username = self.usernameField.text;
    //newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    newUser.userString = @"string set at register";
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
        }
    }];
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [User logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
}

- (UIAlertController *) createAlert {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hey!"
                                                                   message:@"You left a field blank :("
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                         }];
    [alert addAction:cancelAction];
    
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    return alert;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonTapped:(id)sender {
    if (([self.usernameField.text isEqual:@""]) || ([self.passwordField.text isEqualToString:@""])) {
        UIAlertController *alert = [self createAlert];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    } else {
    [self loginUser];
    [self performSegueWithIdentifier:@"signInSegue" sender:nil];
    }
}

- (IBAction)signupButtonTapped:(id)sender {
    if (([self.usernameField.text isEqual:@""]) || ([self.passwordField.text isEqualToString:@""])) {
        UIAlertController *alert = [self createAlert];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    } else {
        [self registerUser];
    }
}
@end
