//
//  UIViewController+SMTNavigationBar.m
//  SMTNavigationBar
//
//  Created by Steffi Tan on 10/8/15.
//  Copyright © 2015 iamsteffi.com. All rights reserved.
//

#import "UIViewController+SMTNavigationBar.h"
#import "SMTSharedNavigationBar.h"


typedef enum BUTTON_SELECTORS{
    LEFT_BUTTON_ACTION,
    RIGHT_BUTTON_ACTION,
    POP_ACTION
    
}BUTTON_SELECTORS;


@implementation UIViewController (SMTNavigationBar)

#pragma mark - Navigationbar configs
#pragma mark -
-(void)willHideBackButton:(BOOL)willHide isAlways:(BOOL)isAlways{
    self.navigationItem.hidesBackButton = willHide;
    if(isAlways){
        [self getSharedNavBar].willHideBackBtnAlways = isAlways;
    }
}

#pragma mark - Create Button
#pragma mark -
-(void)createButtonWithKey:(NSString *)key button:(UIButton *)btn{
    [[self getSharedNavBar] addToButtonList:key button:btn];
}

//-(void)createTitleViewWithKey:(NSString *)key titleImg:(UIImage *)titleImg{

-(void)createTitleViewWithKey:(NSString *)key titleview:(UIView *)v{
 
    [[self getSharedNavBar] addTitleViewList:key titleView:v];
}

#pragma mark - Set title view
#pragma mark -
-(void)setTitle:(NSString *)title key:(NSString *)key isDefault:(BOOL)isDefault{
    
    [[self getSharedNavBar] addTitleList:key title:title];
    
    NSString * titleStr = [(NSString *)[self getSharedNavBar].titleList valueForKey:key];

    self.navigationItem.titleView = nil;
    if(isDefault){
        [self getSharedNavBar].defaultTitle = titleStr;
    }
    self.navigationItem.title = title;
}

-(void)setTitleViewWithKey:(NSString *)key isDefault:(BOOL)isDefault{
    
    UIView * tView = [(UIView *)[self getSharedNavBar].titleViewList valueForKey:key];
    if (isDefault) {
        [self getSharedNavBar].defaultTitleView = tView;
    }
    self.navigationItem.titleView = tView;
}

#pragma mark - Left bar buttons
#pragma mark -

-(void)setLeftBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault isPop:(BOOL)isPop{
    //Removes the "..." appearing during transition
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
    self.navigationItem.hidesBackButton = YES;
    UIButton * btn = (UIButton *)[[self getSharedNavBar].buttonList valueForKey:key];
    [self getSharedNavBar].defaultLeftButton = isDefault? btn:nil;
    
    //Add selector and convert to bar button
    UIBarButtonItem * barBtn;
    
    if(isPop){
        barBtn = [self convertToBarButtonItem:btn withSelector:POP_ACTION];
    }else{
        barBtn = [self convertToBarButtonItem:btn withSelector:LEFT_BUTTON_ACTION];
    }
    [self getSharedNavBar].defaultLeftPop = isPop;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = barBtn;
}

-(void)setLeftBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault withSelectorBlock:(LeftAction_BlockSelector)block{
    
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
    self.navigationItem.hidesBackButton = YES;
    [self getSharedNavBar].defaultLeftPop = NO;
    
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    UIButton * btn = (UIButton *)[snb.buttonList valueForKey:key];
    snb.defaultLeftButton = isDefault? btn:nil;
    
    //Add selector and convert to bar button
    UIBarButtonItem * barBtn;
    
    if((isDefault)&&(block)) {
        snb.leftActionBlock = block;
    }
    barBtn = [self convertToBarButtonItem:btn withSelector:LEFT_BUTTON_ACTION];
    self.navigationItem.leftBarButtonItem = barBtn;
}

#pragma mark - Right bar buttons
#pragma mark -
-(void)setRightBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault{
    
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    
    UIButton * btn = (UIButton *)[snb.buttonList valueForKey:key];
    snb.defaultRightButton = isDefault? btn:nil;
    
    //Add selector and convert to bar button
    UIBarButtonItem * barBtn;
    
    barBtn = [self convertToBarButtonItem:btn withSelector:RIGHT_BUTTON_ACTION];
    self.navigationItem.rightBarButtonItem = barBtn;
}

-(void)setRightBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault withSelectorBlock:(RightAction_BlockSelector)block{
    
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];

    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    self.navigationItem.hidesBackButton = YES;
    UIButton * btn = (UIButton *)[snb.buttonList valueForKey:key];
    snb.defaultRightButton = isDefault? btn:nil;
    
    //Add selector and convert to bar button
    UIBarButtonItem * barBtn;
    
    if((isDefault)&&(block)){
        snb.rightActionBlock = block;
    }
    
    barBtn = [self convertToBarButtonItem:btn withSelector:RIGHT_BUTTON_ACTION];
    self.navigationItem.rightBarButtonItem = barBtn;
}

#pragma mark - Target Selectors
#pragma mark -
-(void)SMTNavigationBarDidTapLeftItem{
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    snb.selfReference = self;
    if(snb.leftActionBlock){
        [snb runLeftActionBlockSelector:nil];
    }
}

-(void)SMTNavigationBarDidTapRightItem{
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    snb.selfReference = self;
    if(snb.rightActionBlock){
        [snb runRightActionBlockSelector:nil];
    }
}

-(void)SMTNavigationBarDidPop{
    //NSLog(@"SELF before pop%@",[self getSharedNavBar].selfReference);
    [[self getSharedNavBar].selfReference.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Super Blocks
#pragma mark -
-(void)runLeftSuperBlock{
    [self getSharedNavBar].selfReference = self;
    [[self getSharedNavBar] runLeftActionBlockSelector:nil];
}

-(void)runRightSuperBlock{
    [self getSharedNavBar].selfReference = self;
    [[self getSharedNavBar] runRightActionBlockSelector:nil];
}


#pragma mark - Utility
#pragma mark -
-(UIBarButtonItem *)convertToBarButtonItem:(UIButton *)btn withSelector:(BUTTON_SELECTORS)selectors{
    
    //Safe mechanism: Need to clear targets to flush selectors associated with the btn.
    [self clearTargetOfBtn:btn];
    
    switch (selectors) {
        case 0:
            [btn addTarget:self action:@selector(SMTNavigationBarDidTapLeftItem) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            [btn addTarget:self action:@selector(SMTNavigationBarDidTapRightItem) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            [btn addTarget:self action:@selector(SMTNavigationBarDidPop) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
    
    UIBarButtonItem * barBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return barBtn;
}

-(SMTSharedNavigationBar *)getSharedNavBar{
    SMTSharedNavigationBar * snb = [SMTSharedNavigationBar sharedNavigationBar];
    return snb;
}

-(void)resetSMTNavigationBar{
    [[self getSharedNavBar] resetSMTNavigationBar];
}

-(void)updateSelfReference{
    [self getSharedNavBar].selfReference = self;
}

-(void)clearSMTNavigationBar{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.titleView = nil;
    self.navigationItem.title = nil;
}

-(void)clearTargetOfBtn:(UIButton *)btn{
    [btn removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Load defaults
#pragma mark -

-(void)loadDefaults{
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    //NSLog(@"load defaults");
    
    //Controller loses self reference when presented coming from a POP.
    //Sol: Update self reference
    [self updateSelfReference];
    
    self.navigationItem.hidesBackButton = snb.willHideBackBtnAlways;
    
    if(snb.defaultLeftButton){
        
        if(snb.defaultLeftPop){
            self.navigationItem.leftBarButtonItem = [self convertToBarButtonItem:snb.defaultLeftButton withSelector:POP_ACTION];
        }else{
            self.navigationItem.leftBarButtonItem = [self convertToBarButtonItem:snb.defaultLeftButton withSelector:LEFT_BUTTON_ACTION];
        }
    }
    
    if(snb.defaultRightButton){
        self.navigationItem.rightBarButtonItem = [self convertToBarButtonItem:snb.defaultRightButton withSelector:RIGHT_BUTTON_ACTION];
    }
    
    self.navigationItem.titleView = nil;
    self.navigationItem.title = nil;
    
    if (snb.defaultTitle) {
        self.navigationItem.title = snb.defaultTitle;
    }
 
    if (snb.defaultTitleView){
        /**
         *  As recommended, keep loadDefaults on viewWillAppear.
         *  Need to re-alloc defaultTitleView to avoid it in being overriden on
         *  viewWillAppear.
         *  Overriden behaviour: The titleview disappears on the navigation bar
         *  even if defaultTitleView value is existing.
         */
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:snb.defaultTitleView.frame];
        imgView.image = snb.defaultTitleViewImage;
        self.navigationItem.titleView = imgView;        
    }
    
}

-(void)loadDefaultWithItem:(DEFAULT_ITEMS)item{
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    [self updateSelfReference];
    
    switch (item) {
        case LEFT_ITEM:
            self.navigationItem.leftBarButtonItem = [self convertToBarButtonItem:snb.defaultLeftButton withSelector:LEFT_BUTTON_ACTION];
            break;
        case RIGHT_ITEM:
            self.navigationItem.rightBarButtonItem = [self convertToBarButtonItem:snb.defaultRightButton withSelector:RIGHT_BUTTON_ACTION];
            break;
        case TITLE_ITEM:
            self.navigationItem.title = snb.defaultTitle;
            break;
        case TITLEVIEW_ITEM:
            self.navigationItem.titleView = snb.defaultTitleView;
            break;
        default:
            NSLog(@"Item couldnt be found.");
            break;
    }

}

@end
