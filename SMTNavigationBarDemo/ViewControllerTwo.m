//
//  ViewControllerTwo.m
//  SMTNavigationBarDemo
//
//  Created by Steffi Tan on 10/9/15.
//  Copyright © 2015 iamsteffi.com. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "UIViewController+SMTNavigationBar.h"

@interface ViewControllerTwo ()

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self setTitleViewWithImage:[UIImage imageNamed:@"logo.png"]];

}

//IMPORTANT: Reference should always be updated on viewWillAppear
-(void)viewWillAppear:(BOOL)animated{
    [self loadDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pop:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)SMTNavigationBarDidTapRightItem{
    
    UIAlertController * c = [UIAlertController alertControllerWithTitle:@"Alert" message:@"You've tapped the right bar button item on second vc" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [c addAction:ok];
    
    [self.navigationController presentViewController:c animated:YES completion:nil];
}

-(void)SMTNavigationBarDidTapLeftItem{
    //Calls the previous created block method
    [self runLeftSuperBlock];

    UIAlertController * c = [UIAlertController alertControllerWithTitle:@"Alert" message:@"You've tapped the left bar button item on second vc. You should see logs of your block code if you created blocks" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [c addAction:ok];
    
    [self.navigationController presentViewController:c animated:YES completion:nil];
    
    //NSLog(@"You tapped the left item!");
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
