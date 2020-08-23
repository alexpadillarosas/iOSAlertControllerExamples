//
//  ViewController.m
//  AlertControllerExamples
//
//  Created by alex on 23/8/20.
//  Copyright © 2020 alex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)modalButtonPressed:(id)sender {
    //create here a UIAlertController
    UIAlertController* alert = [[UIAlertController alloc] init];
    [alert setTitle:@"howdy"];
    [alert setMessage:@"You tapped me"];
    [alert modalPresentationStyle];
    
    //we need this code to give the user an option to dismiss the dialog
    UIAlertAction* yesButtonAction = [UIAlertAction actionWithTitle:@"Yes, Please" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Handle your yes please button action here
        NSLog(@"you tapped Yes");
    }];
    [alert addAction:yesButtonAction];
    
    UIAlertAction* noButtonAction = [UIAlertAction actionWithTitle:@"No, Thanks" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Handle here your No thanks button action
        NSLog(@"You tapped No");
    }];
    [alert addAction:noButtonAction];
    
    //show the alert controller
    [self presentViewController: alert animated:YES completion:nil];
    
}

- (IBAction)alertButtonPressed:(id)sender {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Destroy the World?" message:@"with great power comes great responsibility" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"You have saved the planet");
    }];
    [alert addAction:yesAction];
    
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"mmm maybe later");
    }];
    [alert addAction:noAction];
    
    [self presentViewController:alert animated:YES completion:^{
        //code here what to do after the alert has been shown to the user
        NSLog(@"all has been done");
    }];
}

- (IBAction)alertSingleTextFieldPressed:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"Confirm this operation" preferredStyle:UIAlertControllerStyleAlert];
    //add the TextField to the alert
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [textField setPlaceholder:@"Current password"];
        [textField setSecureTextEntry:YES];
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    }];
    
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *password = [alert textFields][0];
        if ([[password text] isEqualToString:@""]) {
            NSLog(@"password can't be empty");
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            NSLog(@"password update in progress...");
        }
    }];
    [alert addAction:confirmAction];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancelled");
    }];
    [alert addAction:cancelAction];
    
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)alertLoginButtonPressed:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Login" message:@"We need to confirm your identity" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    [textField setPlaceholder:@"email"];
    [textField setTextColor:[UIColor blueColor]];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        
    }];

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    [textField setPlaceholder:@"password"];
    [textField setTextColor:[UIColor blueColor]];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setSecureTextEntry:YES];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        
    }];
    
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSArray* textFields = [alert textFields];
        UITextField *userId = textFields[0];
        UITextField *password = textFields[1];
        
        if(![self validateEmail:[userId text]]) {
            [alert setMessage:@"Invalid email format, please trye again"];
            NSLog(@"Invalid email format, please trye again");
            [self presentViewController:alert animated:YES completion:nil];
        }else{
        
            if ([[password text] isEqualToString:@""]) {
                [alert setMessage:@"password can't be empty, try again"];
                NSLog(@"password can't be empty");
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                NSLog(@"Login in progress...");
                //here we can get the username and password
                NSLog(@"userId: %@", [userId text]);
                NSLog(@"password: %@", [password text]);
            }
        }
    }];
    [alert addAction:confirmAction];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancelled");
    }];
    [alert addAction:cancelAction];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

@end
